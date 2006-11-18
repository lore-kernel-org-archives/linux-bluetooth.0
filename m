Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <455EE00B.80504@free.fr>
Date: Sat, 18 Nov 2006 11:27:23 +0100
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <455CCAF4.8020007@silicom.fr>
	<7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EA7@eumonex01.palmsource.com>
In-Reply-To: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EA7@eumonex01.palmsource.com>
Subject: Re: [Bluez-devel] RE :  SCO on bluez : some architectural tips
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2079102473=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============2079102473==
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit

Hi Frederic

> Hi Fabien,
> 
>> However, due to the fact a2dp is not supposed to be used for delay sensitive
>> streams, it is possible to use this architecture for a2dp. :-)
> 
> A2DP data are certainly not sensitive, but having the sound of your movie playing
> with delay is really unpleasant. So in the end the need for low latency is probably
> the same in SCO and A2DP.

Yes and No :-)
I agree having the sound of your movie played with delay is unpleasant.

However even if it takes one second between the moment the player sents
audio data and the moment it is heared by you, it is this possible to
have audio and video in sync if the player sends desyncs audio and video
 of one second. For instnace, mplayer + and - keys allows you to do just
that.


> 
>>>From my point of vue, having the SCO socket inside application is not needed.
> The benefit is one single unix socket transfer. In a typical video conferencing
> application used on the internet, the delay used for transmitting data will probably
> be by far more important than the delay induced by this transfer. So any gain
> on the SCO side would be made negligible against what is lost during transmission.

I don't agree with that. It's not uncommon these days to have ~ 50 ms
latency between one point fo the internet and the other. (ok not at the
other side of the planet tough :-) )
Let' say you use a unix socket. Sco sockets have a fixed queue length
(something like 1 kb if i remember : this should be checked). Each SCO
packets is 48 bytes, with 'lasts' 3 msec. Which means we can fit
20 packets, or 60 ms data.
Congratulations, we just added more delay that the network itself !! ;-)

Cheers,

Fabien


--===============2079102473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============2079102473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============2079102473==--
