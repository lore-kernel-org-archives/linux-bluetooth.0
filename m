Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45227827.1090001@xmission.com>
Date: Tue, 03 Oct 2006 08:48:07 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <9cc82a4d0610020710q17efb8efk99079c5f943ddaf8@mail.gmail.com>	<4521D073.1030105@xmission.com>
	<45221882.3020809@palmsource.com>	<9cc82a4d0610030425g3c078f62o77fd4d29318c4bee@mail.gmail.com>	<45226231.6080203@palmsource.com>
	<9cc82a4d0610030619qbc160fdqe983cb529e5f8c02@mail.gmail.com>
In-Reply-To: <9cc82a4d0610030619qbc160fdqe983cb529e5f8c02@mail.gmail.com>
Subject: Re: [Bluez-devel] Bluez article on OReillyNet
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

Guylhem

> Unfortunately, the ARM machines I have only have serial ports ....
> I will try to have them chips on HWUART which should not have speed problems.

fwiw, gumstix had a promising pxa board including bluetooth but not
quite enough flash to fit alsa. in their newer boards they have more
flash but they can't figure out how to get the new bluetooth adapter to
switch into a rate faster than 56kbps. :(

I've been trying to connect a csr module to it but it hasn't come
together so far.

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
