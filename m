Return-Path: <benlau@linux.org.hk>
Message-ID: <3F28762C.2010409@linux.org.hk>
Date: Thu, 31 Jul 2003 09:51:40 +0800
From: Ben Lau <benlau@linux.org.hk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Basic Imaging  Profile support
References: <3F2739C5.5040503@linux.org.hk>
	<1059603308.1831.17.camel@pegasus>
In-Reply-To: <1059603308.1831.17.camel@pegasus>
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

    Thanks you for answering me.

    I just want to be able to transfer image between the iPAQ (or any
linux device) , as I see it is getting move devices which is support BIP.

    How is the support of OBEX now?

    I have not read though the BIP specification yet, i read from the
Implementation Guide , it said :

"In principle, it's relatively simple for a device that already supports
one of the Generic
Object Exchange-basedprofiles to support the Basic ImagingProfile as
well. Indeed,
the Basic Imaging profile utilises the same protocol stack as the other
Generic
Object Exchange-based profiles, thus limiting the extra development
workrequired."

    BTW, I  found a website

http://oss.bdit.de/opd.html

    Do somebody here tried with it?

Marcel Holtmann wrote:
> Hi Ben,
> 
> 
>>    I need to do a project in a iPaq with bluetooth support. It required
>>the BIP(basic imaging profile) support.
>>Did bluez support this profile yet? Or any body are working on it? If it
>>is not  , do it difficult to write the profile
>>support for Bluez? I am interested to do so. Any documents in web can be
>>used for reference?
> 
> 
> the Basic Imaging Profile is very complex. What do you need? It exists
> an initial BIP push daemon and we have obex code in CVS.
> 
> Regards
> 
> Marcel
> 
> 
