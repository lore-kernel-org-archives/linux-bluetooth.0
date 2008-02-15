Return-Path: <cyrus@holtmann.org>
Message-ID: <47B5B3FA.1050107@wurmsdobler.org>
Date: Fri, 15 Feb 2008 15:47:06 +0000
From: Peter Wurmsdobler <peter@wurmsdobler.org>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Missing: big picture
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello,

For the past few month help requests come up repeatedly on this list, 
requests that are related to audio, headset, pass key - you name it. In 
my opinion this is due to a missing overall understanding rather than to 
unpredictable code behavior. At least for me, I miss an overall document 
describing the architecture to a new user's eyes.

I recognise that all the developers do a great job implementing features 
and advancing fast. They do a great job, but are far too deep in the 
matter in order to understand the comprehension difficulties of a 
newcomer. Certainly all reasons why there is no "big picture". The 
sparse collection of Wikis does not help either. Of course, look at the 
code is always an option, but it is time consuming.

Where is my problem? I see, on the one hand there is the well defined 
stack model. On the other, there is a collection of demons in user space 
and a bunch of kernel modules. But how does is hang together? What is 
the designed start-up sequence?

A bluetooth chip would be connected over different physical media such 
as UART, USB and SDIO to a linux host. Is it correct to assume that the 
respective kernel drivers will abstract the different physical transport 
media into the HCI interface?

By some magic (to me) hciattach creates socket interfaces hciX. I have 
added a service at start-up that does this, as in my case, the BC4-ROM 
will be connected permanently to the mx27 host processor. Why is a 
hciattach process required to maintain the hci0 interface? There is no 
equivalent thing for ethernet, is there? Or would it be the job of hcid 
anyway?

What is exactly the role of hcid? Is it to create hciX interfaces, or 
redirecting all communication coming in by the dbus to the proper hciX 
interface?

Assuming that hcid is involved in the creation of hciXes, does the sdpd 
have to be started afterwards, or before?

If passkey-agent and auth-agent are required but not supported, why is 
their service simply not included into the bluez-utils, but is offered 
by kde or gnome implementation, or even in QTopia? Because it involves 
user invention?

Assuming that, like in my case, a BT chip is connected permanently to 
the mx27 host processor, what is supposed to happened in what order? Who 
is involved and what configuration files are required?

In the case of a headset, what are the stages the entire bluetooth stack 
is going through from the moment you set the headset into pairing mode? 
What demons must be running, and how would the state diagram look like?

Now in case of an audio stream being sent from an audio player, how are 
the PCM sample routed to the BT headset (both with PCM data transfer 
over SCO using a dedicated SSI connection between CPU and BT chip, or 
piping the PCM data through HCI)?

One thing I can say, once I understand all that with the help hopefully 
of the list, I will write it up and make nice drawings. The downside 
could, once they are finished they are obsolete.

Regards,
peter


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
