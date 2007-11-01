Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <47293B4E.60508@gmail.com>
Date: Thu, 01 Nov 2007 08:04:54 +0530
From: Mohan Sundaram <mohan.tux@gmail.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <1In7ly-1gisng0@fwd33.aul.t-online.de>
	<1193847468.32459.40.camel@violet>
In-Reply-To: <1193847468.32459.40.camel@violet>
Subject: Re: [Bluez-users] VOIP bluetooth headset
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

Marcel Holtmann wrote:
> Hi Frank,
> Second, you have to blame Skype for not working. Their usage of the ALSA
> API is totally strange and it gets worse with every version. That this
> works with real hardware sound cards, it from my point of view, pure
> luck. With virtual sound cards, like a Bluetooth headset it is not that
> simple and so far I couldn't find a sane way to make Skype happy.
> 
> Regards
> 
> Marcel
I was able to use my Motorola BT headset with Skype on Gutsy. When I was 
able to pair, Skype shows BT headset as an alsa/oss device and choosing 
it worked. My problem is pairing. The headset is not discovered 
consistently by the executable in System >> Preferences >> Bluetooth 
headset. When discovered, if I try to make it the active handset, it 
fails a couple of times and then shows up as unknown <bdaddr>. This did 
work for a couple of days for me before I started having this issue.

Mohan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
