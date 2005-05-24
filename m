Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42936B82.8040603@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] libsbc optimizing
References: <428BD03E.9000307@xmission.com>	 <20050521000412.1499f11e.henryk@ploetzli.ch>	 <428E7D72.3030501@xmission.com> <428E809E.2000208@xmission.com>	 <42935C97.4080508@xmission.com> <1116954613.30044.160.camel@pegasus>
In-Reply-To: <1116954613.30044.160.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Tue, 24 May 2005 11:59:30 -0600

fwiw,

i think this gives us what you're asking for (indirectly). gnu mp has 
hand-optimized assembly backends for a few platforms, including arm. it 
falls back to plain int math for platforms with no targeted assembly.

brad

Marcel Holtmann wrote:
> Hi Brad,
> 
> 
>>it's a little bit strange talking about math libraries here :)
>>
>>i am going to try using gnu mp. it provides rationals and short floats. 
>>i will make it an autoconf option so we keep the regular floating point 
>>implementation in case that's what you want.
> 
> 
> go ahead, but maybe I repeat myself; we need an integer version of the
> SBC codec. This is where we should head with any optimization. However I
> am the wrong person for this stuff, but I would welcome everyone who
> wants to work on it.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Yahoo.
> Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
> Search APIs Find out how you can build Yahoo! directly into your own
> Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
