Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4046088B.5070204@soft.uni-linz.ac.at>
From: Simon Vogl <vogl@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Fred_Sch=E4ttgen?= <bluez-devel@schaettgen.de>
CC: bluez-devel@lists.sourceforge.net,
   James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [Bluez-devel] sco links
References: <4045E93F.4040900@soft.uni-linz.ac.at> <4045F5AF.2000107@superbug.demon.co.uk> <200403031717.06139.bluez-devel@schaettgen.de>
In-Reply-To: <200403031717.06139.bluez-devel@schaettgen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 03 Mar 2004 17:32:11 +0100

Fred Schättgen wrote:

>On Wednesday 03 March 2004 16:11, James Courtier-Dutton wrote:
>  
>
>>Simon Vogl wrote:
>>    
>>
>>>hi,
>>>can anyone help me with my sco link? in about 50% of cases, the audio
>>>data has an offset of one byte, resulting in terrible noise. I think I
>>>saw a flag in a packet header somewhere that indicates the number of
>>>bytes to skip
>>>until the audio data starts -- I looked through the bt specs several
>>>times now
>>>but can't find it again. Anyone has a clue for this?
>>>Simon
>>>      
>>>
>>The terrible noise will be lost interrupts
>>    
>>
>
>I have also noticed that problem. When I just tried with hstest, 2 out of 5 
>tries were noise, the rest was perfect.
>I don't think is has anything to do with interrupts, because the the problem 
>lasts for the whole duration of the connection or it doesn't appear at all.
>Also could I work around that problem somewhat in an own application by 
>guessing the byte order of the 16-bit audio samples. So I also think that 
>there is something wrong with some offset.
>
>  
>
I think too that it corresponds to an alignment problem, as the noise 
energy corresponds what I would
expect as the audio signal

Simon

-- 
_______________________________________________________________________
Dr. Simon Vogl
Institut für Pervasive Computing, Johannes Kepler Universität Linz
Altenberger Straße 69, A-4040 Linz, Austria

Tel: +43 732 2468-8517, Fax: +43 732 2468-8426
mailto: vogl@soft.uni-linz.ac.at,  http://www.soft.uni-linz.ac.at/




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
