Return-Path: <vogl@soft.uni-linz.ac.at>
Message-ID: <406AE027.7030000@soft.uni-linz.ac.at>
Date: Wed, 31 Mar 2004 17:13:43 +0200
From: Simon Vogl <vogl@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: Steven Singer <steven.singer@csr.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List
 <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sco / csr final notes
References: <406A9E23.9000406@soft.uni-linz.ac.at>     <1080730774.2674.6.camel@pegasus> <406AAFFF.6040504@soft.uni-linz.ac.at> <406ADF3E.4020502@csr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>



Steven Singer wrote:
> Simon Vogl wrote:
> 
>>oh, sorry: well, after trying for weeks, I see always the same behavior of
>>the sco data: after a connect of the sco channel, the data is either byte-swapped
>>or offset by one byte, but no indication in any header etc. can be found why
>>this is the case.
> 
> 
> Is the problem that the link spontaneously changes from correct to noisy
> in the middle of a link, or is it that when you start up a link it's
> either OK for the durection of the link, or noisy for the duration of
> the link and then when you tear it down and start a fresh link, the next
> one is, independently, correct our noisy?
> 
> If it's the latter case, is the first link after a full reset (BCCMD
> reset or power cycle - not merely an HCI reset) ever noisy?
> 
the latter is the case. Whenever a fresh sco link starts, I have a 50% chance of
getting the wrong byte order..

I still have to try how it reacts after a cold reset, as I dont have a developer kit -
I just downloaded the bccmd spec, and I need to write a small piece of software to
transmit this command.... But I will tell you as soon as I know.

> 
>>Marcel, do you I can bug with this at csr?
> 
> 
> You should use the CSR public newsgroups (follow the links from the CSR
> web site), though, in practice, making enough noise on this mailing list
> will eventually attract the attention from someone at CSR (there are
> several people here who subscribe).

I have already, thanks, and will beat the bush shortly. I have to get several other
flaws straight first - I am over an important project deadline already, but that's
a different story :(

Simon

> 
> 	- Steven


-- 
_______________________________________________________________________
Dr. Simon Vogl
Institut für Pervasive Computing, Johannes Kepler Universität Linz
Altenberger Straße 69, A-4040 Linz, Austria

Tel: +43 732 2468-8517, Fax: +43 732 2468-8426
mailto: vogl@soft.uni-linz.ac.at,  http://www.soft.uni-linz.ac.at/
