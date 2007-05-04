Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <bd5b16740705040631t42a61ec1s4d72dc5a9c36d8aa@mail.gmail.com>
Date: Fri, 4 May 2007 16:31:15 +0300
From: "Ohad Ben-Cohen" <ohad@bencohen.org>
To: "Sumeet VERMA" <sumeet.verma@st.com>
In-Reply-To: <032e01c78e3f$374b8b10$8935c70a@dlh.st.com>
MIME-Version: 1.0
References: <bd5b16740704300324i5f4f527aq50777d136e7a108f@mail.gmail.com>
	<032e01c78e3f$374b8b10$8935c70a@dlh.st.com>
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Low Power mode in bluez
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Sumeet,

On 5/4/07, Sumeet VERMA <sumeet.verma@st.com> wrote:
> I saw the patch you sent. In the application hciattach, I see that you read
> the commands from a script file and send it to the controller. If you see a
> deep sleep command you stop the execution of the script and return.

This command is just a configuration command; it let's the device know
it can begin initiating deep sleeps. I don't stop the execution of the script,
I just postpone it - I want hciattach to first set HCILL protocol in the kernel
before I continue.

> My question is how does the device wake up and how do you put the device in
> deep sleep mode after the initialization is done.

This is all up to the device.
Once it is permitted to initiate deep sleeps, the device may request it anytime
it wants (it has some inactivity timers for that).

The HCILL protocol's duty is to allow the device to deep sleep anytime
it wants. Later, when data is to be sent to the device, the HCILL protocol
make sure it is awake. If not, it awakes the device, and only then send
the pending data.

> I mean do you check for
> any activity on the bluetooth link and if there is no activity (say for 10
> sec) you send the command to put your device in deep sleep mode.

No, this is all up to the device. Only the device can initiate deep sleeps.

> Is this done in the uart driver?

Everything is done in the HCI Line Discipline.
No change to the uart driver.

>
> With the code you send I think once the hciattach is started, the device may
> go into deep sleep mode. But if it wakes up, it will not go into deep sleep
> mode again (atleast not from the application/stack).

hciattach only turn on the device's deep sleep mode; it doesn't ask the device
to sleep. Once this mode is turned on, the device can start asking to sleep.
The host can only grant its request, and wake it up in a later time. The host
cannot request the device to sleep (it is not needed, because the device
sense inactivities and immediately requests to deep sleep).

This whole solution relies on the hardware to be able to request deep sleeps.
It is tailored to TI's BRF chips, which can initiate deep sleeps and
spontaneously
awake if needed.
If you are looking for pure software solution it's not enough, sorry.
I guess it can be tweaked to allow software initiations, too, but there are
subtle races you should seriously think about when/if doing it.

BR,
Ohad.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
