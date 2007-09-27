Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46FB713C.2040000@kernelconcepts.de>
Date: Thu, 27 Sep 2007 11:00:44 +0200
From: Nils Faerber <nils.faerber@kernelconcepts.de>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <BAY125-W32A371D4F0BDD0BAC18B63F1B10@phx.gbl>
In-Reply-To: <BAY125-W32A371D4F0BDD0BAC18B63F1B10@phx.gbl>
Subject: Re: [Bluez-devel] Battery
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

darshan kanani schrieb:
> hi
>  
> i want to display battery status of my mobile in computer via bluetooth
> using blueZ stack with C language.

- open rfcomm channel to your mobile
- issue AT command to mobile to query for battery (see GSM standard
07.07 V7.7.0 or later)
- parse output from modem
- display

> i want documentation with source code.

Which programming language?
Come on, it is quite simple. Search for the above keywords and you
should be able to find all kinds of examples...

> will u help me out?
>  
> regards
> darshan
Cheers
  nils faerber

-- 
kernel concepts GbR        Tel: +49-271-771091-12
Sieghuetter Hauptweg 48    Fax: +49-271-771091-19
D-57072 Siegen             Mob: +49-176-21024535
--

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
