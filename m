Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
In-Reply-To: <OF788B477D.1FF38FBA-ON4825737D.0028CF7D-8825737D.007D2034@mxic.com.cn>
References: <OF788B477D.1FF38FBA-ON4825737D.0028CF7D-8825737D.007D2034@mxic.com.cn>
Message-Id: <EFA2B7E7-4D56-4E8D-8D52-0AA7DED12018@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Tue, 23 Oct 2007 13:02:06 +0300
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluetooth headset not working
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


On Oct 23, 2007, at 10:53, KyoYin@mxic.com.cn wrote:
>     the crash of bluetoothd-service-audio has been resolved now.i  
> think it is a bug.in avdtp_stream_get_transport(),the mtu pointer  
> will be unaccessible.
> In a2dp_setup_complete(),avdtp_stream_get_transport() wants to pass  
> the address of cfg->pkt_len.but the cfg is a packed struct.so the  
> normal pointer of uint16(pointer mtu in avdtp_stream_get_transport  
> is this type) should not be used here.of cause my cpu is arm.

Thanks for this info. It should now be fixed in the CVS.

Johan


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
