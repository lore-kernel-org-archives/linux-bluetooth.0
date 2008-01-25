Return-Path: <cyrus@holtmann.org>
Message-ID: <47999EBE.1010804@naustech.com>
Date: Fri, 25 Jan 2008 09:33:02 +0100
From: "Ing. Gabriele Oberhammer" <gabriele@naustech.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4795D6EB.2080209@naustech.com>	<1201018471.24085.4.camel@littletux>
	<47986354.2080205@naustech.com>	<d89ddf300801240717g61e06642v28d6f0cf1b3cf2da@mail.gmail.com>	<479911A2.6040704@naustech.com>
	<d89ddf300801241520x440c0714lbe996ac3ac6aced9@mail.gmail.com>
In-Reply-To: <d89ddf300801241520x440c0714lbe996ac3ac6aced9@mail.gmail.com>
Subject: Re: [Bluez-users] Headset half working using Bluez's ALSA plugin
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


Brad Midgley wrote:

> iirc, there was a patch for recording that was committed to cvs after
> 3.24 was released. Did you already try the latest?
> 
Hi,

Yes, I was aware about that patch. I red about it in your message to 
Chip McArtor on 9gen2008 and that it solved Chip problem.

I built blue-utils form 23gen2008 CVS, but did not solve the problem for me.
Could it be related to my bluetooth CSR adapter Class?
I saw that Chip adapter is recognized as 'Class: 0x080100' but my is 
'Class: 0x08210c'

Can I use hcidump to get some useful debug informations?

Thanks for your time :-)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
