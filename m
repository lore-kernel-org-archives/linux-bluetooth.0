Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andreas Fehr <andreas@mrs.ch>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth serial vs. audio connection
In-Reply-To: <1112006630.9016.3.camel@pegasus>
Message-ID: <Pine.LNX.4.62.0503281310300.3475@ybpnyubfg.ybpnyqbznva>
References: <Pine.LNX.4.62.0503271303450.3134@ybpnyubfg.ybpnyqbznva>
 <1111923433.9195.216.camel@pegasus>  <Pine.LNX.4.62.0503271357080.3134@ybpnyubfg.ybpnyqbznva>
  <1111926923.9195.218.camel@pegasus>  <Pine.LNX.4.62.0503271736360.3135@ybpnyubfg.ybpnyqbznva>
  <1111938339.9195.229.camel@pegasus>  <Pine.LNX.4.62.0503271751420.3135@ybpnyubfg.ybpnyqbznva>
  <1111939568.9195.236.camel@pegasus>  <Pine.LNX.4.62.0503271813180.3135@ybpnyubfg.ybpnyqbznva>
  <1111942691.9195.241.camel@pegasus>  <Pine.LNX.4.62.0503280908130.3082@ybpnyubfg.ybpnyqbznva>
  <Pine.LNX.4.62.0503281112030.3082@ybpnyubfg.ybpnyqbznva>
 <1112006630.9016.3.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 28 Mar 2005 13:13:28 +0200 (CEST)

On Mon, 28 Mar 2005, 12:43, Marcel Holtmann (as MH) wrote:

Hi Marcel,

>MH: > Well, I tried to debug this segmentation fault, but the changes I 
>MH: > made in the code haven't been reflected in the binary. I'm not 
>MH: > that experienced as a programmer, so I don't know what happened 
>MH: > (probably due to the static declaration of the functions?)
>MH: 
>MH: what happens is quite clear. It is a Sequence against a Sequence of 
>MH: Sequence clash. There is another thread in the mailing list with 
>MH: this exact problem and a lot of explanation. However nobody fixed 
>MH: this so far.

Well, I'm happy this sounds clear for you... :-)))

But I'll leave it for that. The hint with the channel did the trick 
(perhaps, something like that should be documented somewhere? or is it 
already?)

Thanks for all your time to help me solving this problem.

Andreas


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
