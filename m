Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <9821BE34-CDB9-4596-AD9F-A98D75F2FD14@hadess.net>
References: <1317905191-30118-1-git-send-email-luiz.dentz@gmail.com>
	<CAMOw1v5_EJNp3cS8u9QvKA87yELF7FE-nFAm_jSNWbtm_i4g_Q@mail.gmail.com>
	<CABBYNZ+Dfe4uSJNG398DmmZC0Y3ooouj-Kdi5dcnAhbHiQHOrQ@mail.gmail.com>
	<CAMOw1v7BDd+a9XxGJw+gzVnvrOpEvzSDr-HHz23eR7XRATpEfw@mail.gmail.com>
	<9821BE34-CDB9-4596-AD9F-A98D75F2FD14@hadess.net>
Date: Sun, 9 Oct 2011 12:14:52 +0300
Message-ID: <CABBYNZJyi7aC+ZDZAF7KMqKVsnqD_hMZ1eHkxGcA0vPLRoWcnQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Add mpris-player to test
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Sat, Oct 8, 2011 at 7:13 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On 8 Oct 2011, at 16:34, Lucas De Marchi <lucas.demarchi@profusion.mobi> wrote:
>
>> Hi Luiz,
>>
>> It's working well here with rhythmbox. Sadly it's the only player I
>> found that implements this version.
>>
>> Don't forget to add test/mpris-player to .gitignore.
>
> Totem 3.2 has MPRIS 2 support.

Btw, it is probably best to implement this interface directly on the
players so we cut the proxy that is what mpris-player is doing.

Regards,

-- 
Luiz Augusto von Dentz
