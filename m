Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "mailing_list@orange.nl" <mailing_list@orange.nl>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1191746631.10698.176.camel@violet>
References: <1191696694.2049.7.camel@Gentoo-desktop.lan>
	<d89ddf300710062041q59531981xe2a3c693960bff40@mail.gmail.com>
	<1191740426.5622.4.camel@Gentoo-desktop.lan>
	<1191746631.10698.176.camel@violet>
Date: Sun, 07 Oct 2007 10:55:15 +0200
Message-Id: <1191747315.5622.9.camel@Gentoo-desktop.lan>
Mime-Version: 1.0
Subject: Re: [Bluez-users] How do I get a bluetooth headset working?
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

I did make a texfile in my home directory named '.asoundrc' with the
following input (I obtained the address through hcitool)

pcm.bluetooth {
   type bluetooth
   device 00:11:22:33:44:55
}

But how do I proceed using it with Skype? 


On Sun, 2007-10-07 at 10:43 +0200, Marcel Holtmann wrote:
> Hi Aniruddha,
> 
> > Thank you for answer. I have read the manual, unfortunately it lists
> > only commands without an explanation. Therefor I find it really
> > difficult to grasp. 
> 
> and if you read it carefully enough, then you would have realized that
> setting up your .asoundrc with the BD_ADDR of your headset would be
> enough to make this work.
> 
> Regards
> 
> Marcel
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
