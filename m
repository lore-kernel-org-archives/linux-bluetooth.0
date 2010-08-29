Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100829101959.GA10891@jh-x301>
References: <CF9C39F99A89134C9CF9C4CCB68B8DDF25AB2D2864@orsmsx501.amr.corp.intel.com>
	<20100828082256.GA23228@jh-x301>
	<CF9C39F99A89134C9CF9C4CCB68B8DDF25AB2D28E0@orsmsx501.amr.corp.intel.com>
	<AANLkTi=K6rdg+Pck7FjbDP-LTn=5sXrLVX9Nz8RPqi0v@mail.gmail.com>
	<20100829101959.GA10891@jh-x301>
Date: Sun, 29 Aug 2010 19:28:29 +0530
Message-ID: <AANLkTinHLGYkji4Eoxu_QReDQCHndB7r319jB-2butVT@mail.gmail.com>
Subject: Re: Cannot build BlueZ Release 4.70...
From: alok barsode <alokbarsode@gmail.com>
To: alok barsode <alokbarsode@gmail.com>, "Ho, Albert O" <albert.o.ho@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"marcel@holtmann.org" <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Sun, Aug 29, 2010 at 3:49 PM, Johan Hedberg <johan.hedberg@gmail.com> wr=
ote:
> Hi,
>
> On Sun, Aug 29, 2010, alok barsode wrote:
>> > The configure line invocation is taken from README file. =A0Below are
>> > copy-paste exact errors.
>>
>> I tried building using bootstrap-configure and it built fine. =A0But
>> when I tried building with ./bootstrap and ./configure =A0it gave the
>> same errors as mentioned.
>> Maybe we missed some configure option ?
>
> I still can't seem to reproduce this. I just tried "./bootstrap &&
> ./configure && make" with a clean git tree and it compiles fine.
> Downloading the official tarball for 4.70 and doing "./configure &&
> make" works fine too. I wonder if the autotools or gcc version has
> something to do with this?

I dont think this is a autotools issue.(my autoconf ver is 2.64 and
automake ver is 1.11
gcc version is 4.4.1. which are fairly new).

If I give "--enable-alsa" option to configure it builds fine.
acinclude.m4 sets the SBC variable  if either alsa or gstreamer or
test are enabled via configure.

 In Makefile.am , the attrib_sources are put under SBC conditional.

I dont have much idea about attrib, maybe put the attrib_sources under
a ATTRIBPLUGIN conditional might solve this issue?

Cheers,
Alok.
>
> Johan
>
