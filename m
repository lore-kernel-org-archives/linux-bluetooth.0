Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Sumeet VERMA <sumeet.verma@st.com>
To: "'Ohad Ben-Cohen'" <ohad@bencohen.org>
Date: Fri, 4 May 2007 16:57:35 +0530
Message-ID: <032e01c78e3f$374b8b10$8935c70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <bd5b16740704300324i5f4f527aq50777d136e7a108f@mail.gmail.com>
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

Hi Ohad
I saw the patch you sent. In the application hciattach, I see that you read
the commands from a script file and send it to the controller. If you see a
deep sleep command you stop the execution of the script and return.
My question is how does the device wake up and how do you put the device in
deep sleep mode after the initialization is done. I mean do you check for
any activity on the bluetooth link and if there is no activity (say for 10
sec) you send the command to put your device in deep sleep mode.Is this done
in the uart driver?

With the code you send I think once the hciattach is started, the device may
go into deep sleep mode. But if it wakes up, it will not go into deep sleep
mode again (atleast not from the application/stack). 

Regards,
Sumeet 
-----Original Message-----
From: Ohad Ben-Cohen [mailto:ohad@bencohen.org] 
Sent: Monday, April 30, 2007 3:54 PM
To: Sumeet VERMA
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Low Power mode in bluez

Hi Sumeet,

> From: Sumeet VERMA <sumeet.verma@st.com>
>
> I meant deep sleep modes by low power modes. I think I would need some 
> support in bluetooth transport layer for that.

I'm not so sure what is it that you need, but it sounds like the kernel
patch I sent earlier today might be of interest to you; The patch implements
deep sleep modes via transport layer manipulations (the patch is actually a
new HCI line discipline protocol).

These deep sleep modes are part of TI's HCILL runtime power management UART
protocol.

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
