Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300710261446v53c110e2lea0793a98ba5e450@mail.gmail.com>
Date: Fri, 26 Oct 2007 15:46:41 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <47224D7E.3080901@hccnet.nl>
MIME-Version: 1.0
References: <4720C85B.1090300@hccnet.nl> <1193352494.6184.290.camel@violet>
	<4721E348.2060403@hccnet.nl> <472213B6.50402@hccnet.nl>
	<d89ddf300710261035r613fee0pe09aa130f348398c@mail.gmail.com>
	<47224D7E.3080901@hccnet.nl>
Subject: Re: [Bluez-users] Audio gaps with bcm2035 and Hama receiver
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

Remy

Did you already check the link mode & policy? If you have "master" in
hcid.conf's lm setting and you take "rswitch" and "sniff" out of the
lp setting, you are forcing the pc to be master and to hopefully
behave better. (be sure to restart hcid)

Brad

On 10/26/07, Remy Bosch <reboli@hccnet.nl> wrote:
> Brad Midgley wrote:
> > Remy
> >
> > Is this last attempt using v3.22?
> >
>
> Just tested and the package builds. The gaps on the other hand are still
> there. I can't determine what causes the gaps. I just notice that for a
> few seconds the sound is gone though the clock keeps ticking. So, for
> some time the sound appears to go to /dev/null.
> The patch for 2.6.23 kernel does not help either. It got even worse, but
> I'll stick to the current setup which is 2.6.22.
> As mentioned before, I have a USB based BCM2035.
> The receiver
>
> - Bluetooth class 1: max. range: 100 m
> - Bluetooth standard V1.2 (supports stereo profile A2DP)
>
> Any thoughts?
> Thanks!
>
> Remy
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
