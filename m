Return-Path: <cyrus@holtmann.org>
Message-ID: <f9d4bd30810141147o60a2b0ban3773a949b5c6c236@mail.gmail.com>
Date: Tue, 14 Oct 2008 15:47:29 -0300
From: "Claudio Takahasi" <claudio.takahasi@openbossa.org>
To: "Bastien Nocera" <hadess@hadess.net>
Subject: Re: [PATCH] Fix possible crash on startup
Cc: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
	"Johan Hedberg" <johan.hedberg@gmail.com>,
	"BlueZ development" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1223907411.31961.3251.camel@cookie.hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1223766202.31961.868.camel@cookie.hadess.net>
	 <FA1352D8-03D2-4979-99A4-5EFE5EB8872E@gmail.com>
	 <2d5a2c100810130643h81e09f0qc3c9cd57602867e7@mail.gmail.com>
	 <1223907411.31961.3251.camel@cookie.hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2008/10/13 Bastien Nocera <hadess@hadess.net>:
> On Mon, 2008-10-13 at 10:43 -0300, Luiz Augusto von Dentz wrote:
>> Hi,
>>
>> I guess we can make all driver to do the discover on Connect if the
>> record is not available, similar to what is done in audio.
>
> I'm not certain whether the problem is no record, or a broken one.
>
> This is the file causing problems, the device line that causes the crash
> is the one starting with 00:1E:45:AD:F1:96. So there is data, but it
> probably isn't parsed properly.
>
> Cheers
>

Hi,

The source of this problem is an invalid sequence in the service
record. See entry 00:1E:45:AD:F1:96#02008007 in sdp record file.
About the Johan's questions:
1. we can access rec->handle directly, we have to fix it
2. service record is necessary, at least HIDDescriptorList

Claudio
-- 
--
Claudio Takahasi
Instituto Nokia de Tecnologia
Recife - Pernambuco - Brasil
+55 81 30879999
