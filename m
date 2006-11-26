Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <002901c710a8$0eab3580$0100a8c0@kayleigh>
References: <002901c710a8$0eab3580$0100a8c0@kayleigh>
Date: Sun, 26 Nov 2006 11:13:25 +0100
Message-Id: <1164536005.25914.8.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Master / Slave question
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Olivier,

> I am trying to make 2 mobile phones connected concurrently
> to a RFCOMM server. Please note that they don't support
> role switching, so as they initiate the communication, they
> are always "master".
>  
> My RFCOMM server is a forking one so it can virtually
> deal with concurrent clients like on TCP.
>  
> I have put lm=accept in hcid.conf
>  
> If I open a RFCOMM server on channel 14 and try to make
> the 2 mobile connect to channel 14, the first is ok, the
> second can't connect. I suppose that's normal, because
> channel 14 "slave" is busy linux-side with the first
> connection and a "slave" can deal with one connection only.
>  
> Then I've launched a second server on channel 15 (server
> on channel 14 running concurrently), and i try to make
> the first mobile connect to channel 14 and the second
> to channel 15 : it's the same, only the first can connect.
>  
> I think I have a misunderstanding here, as i thought the
> "master/slave" was per channel. Does it mean the "slave" status 
> is for the whole adaptor, and once a "slave" connection is
> open on one channel, it can't receive other connections at all ?

the master/slave thing is per ACL connection. However there can only be
one ACL connection between two devices. Run "hcidump -X -V" and see
what's the actual error message on the HCI level.

Regards

Marcel




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
