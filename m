Return-Path: <vogl@soft.uni-linz.ac.at>
Message-ID: <406AAFFF.6040504@soft.uni-linz.ac.at>
Date: Wed, 31 Mar 2004 13:48:15 +0200
From: Simon Vogl <vogl@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sco / csr final notes
References: <406A9E23.9000406@soft.uni-linz.ac.at> <1080730774.2674.6.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

oh, sorry: well, after trying for weeks, I see always the same behavior of
the sco data: after a connect of the sco channel, the data is either byte-swapped
or offset by one byte, but no indication in any header etc. can be found why
this is the case.

The original assumption that there might be packets with a byte (or more)
missing has not turned out to be right (could not find an indication of this).

Anyway, as a workaround, I have implemented a small signal analysis function that
tests, in short, if the incoming signal is gaussian or even distributed (the latter
is an indication for a byte swap) - upon which I adapt the output accordingly.
(the code is at http://www.soft.uni-linz.ac.at/_wiki/tiki-index.php?page=ProjectBluezHandsfree)

Marcel, do you I can bug with this at csr?
Simon

Simon

Marcel Holtmann wrote:
> Hi Simon,
> 
> 
>>well now I have a heuristic that works most of the time. Looking at the
>>transmitted data, I wonder if there could be a big endian/little endian
>>switch that is toggled randomly in the firmware for the 16bit sco data.
>>
>>Is there a lucky person with a developer kit out there who is able
>>to confirm this?
> 
> 
> please remind us about what your are talking, because it seems that at
> least I forgot it. If you think you found a bug and you are able to
> reproduce it, you should make a detailed description, so the CSR guys
> can fix it.
> 
> Regards
> 
> Marcel
> 


-- 
_______________________________________________________________________
Dr. Simon Vogl
Institut für Pervasive Computing, Johannes Kepler Universität Linz
Altenberger Straße 69, A-4040 Linz, Austria

Tel: +43 732 2468-8517, Fax: +43 732 2468-8426
mailto: vogl@soft.uni-linz.ac.at,  http://www.soft.uni-linz.ac.at/
