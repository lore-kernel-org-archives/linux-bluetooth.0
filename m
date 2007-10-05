Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300710051649y61ba5838s43baa48a65bfb536@mail.gmail.com>
Date: Fri, 5 Oct 2007 17:49:04 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <4706B480.8000907@pyrocufflink.net>
MIME-Version: 1.0
References: <4706B480.8000907@pyrocufflink.net>
Subject: Re: [Bluez-users] Configuring BlueZ to provide audio sink service
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

Dustin

a2dp source hasn't been reimplemented inside bluez yet. Check out the
old prototype--see the bottom of
http://bluetooth-alsa.sourceforge.net/build.html

Brad

On 10/5/07, Dustin C. Hatch <admiralnemo@pyrocufflink.net> wrote:
> Hello all,
>
> I am currently working on a line-audio over Bluetooth solution.  My plan
> is to play audio on my tablet PC in Windows Media Player and have it
> played on my desktop's stereo system. It would seem that this would be
> possible using A2DP, setting the tablet as the "source" and the desktop
> as the "sink."  I am having trouble, however, configuring BlueZ to
> provide the "audio sink" service.  Google searching doesn't turn up
> much, mostly information on configuring BlueZ to be the source.
>
> If anyone has some pointers, suggestions, etc. I would be glad to hear
> them.  I plan to post all my findings and complete documentation on my
> procedures on the Web when I am finished.
>
> It may be important to note that the desktop is running Gentoo Linux
> (2.6.22) and the tablet is Windows Vista Ultimate x64.  The desktop has
> an HP BT450 USB Bluetooth adapter and the tablet has a built-in Broadcom.
>
> Thanks,
> Dustin C. Hatch
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
