Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <13960213768f.13768f139602@fh-wolfenbuettel.de>
References: <13960213768f.13768f139602@fh-wolfenbuettel.de>
Date: Tue, 30 May 2006 12:40:45 +0200
Message-Id: <1148985645.17015.3.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] SDP without results
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

Hi Goetz,

> I am trying to discover services of a device, looking for the SAP
> service. In my understanding this is the hex ID for uuid  0x112d .
> 
> I have been trying to use the sample of Albert Huang
> (http://people.csail.mit.edu/albert/bluez-intro/)   section 4.4 .
> 
> The service id is defined as
>     uint32_t svc_uuid_int[] = { 0x0, 0x0, 0x0, 0x112d };

you use of sdp_uuid128_create() is wrong and also not needed at all. It
is enough to add the UUID16 identifier for this kind of search. The
bluez-utils source packages contains enough examples on how to search
for specific services.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
