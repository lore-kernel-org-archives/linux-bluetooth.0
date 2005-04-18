Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Baseband Packets
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <d1f423d305041815331d2e6698@mail.gmail.com>
References: <12a241ad050415175936c651a1@mail.gmail.com>
	 <1113623792.16433.49.camel@pegasus>
	 <d1f423d305041815331d2e6698@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1113864236.16233.148.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 19 Apr 2005 00:43:56 +0200

Hi Anderson,

> The spec says that: "Quality measurements in the receiver of one
> device can be used to dynamically control the packet type transmitted
> from the remote device for optimization of the data throughput."
> 
> The question is, is it done automatically or not? May we assume that
> LM is smart enough to measure the RF channel and based on it changes
> automatically the packet type ?

the link manager should be smart enough, but choosing the right packet
type is a science by itself.

> If not, is there any point in bluez that we can talk with LM?

We can only limit available packet types, but this makes no sense at all
and should never be done.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
