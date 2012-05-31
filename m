Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CA+QXtDtja--pKFO36DuKRxmiEzN9_d6j5aFHbPu6mdoS2ARmNw@mail.gmail.com>
References: <1338453008-15947-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1338453008-15947-2-git-send-email-frederic.dalleau@linux.intel.com>
	<CABBYNZ++UoBw46_+BbCb0eJ1Utt_8XNtk_tJJy7yaE3bc1V4Ow@mail.gmail.com>
	<CA+QXtDtja--pKFO36DuKRxmiEzN9_d6j5aFHbPu6mdoS2ARmNw@mail.gmail.com>
Date: Thu, 31 May 2012 16:09:31 +0300
Message-ID: <CABBYNZ+P_TaAjBhx4R-eXTk2i9MhYUOByW_YsUe+SjVk4x25EQ@mail.gmail.com>
Subject: Re: [PATCH] network: Reply to extensions at connection setup
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Dalleau, Frederic" <frederic.dalleau@intel.com>
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Thu, May 31, 2012 at 3:09 PM, Dalleau, Frederic
<frederic.dalleau@intel.com> wrote:
> Luiz,
>
> On Thu, May 31, 2012 at 12:38 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Frédéric,
>> Perhaps you can have a macro for getting just the header type without
>> the extension bit e.g. BNEP_HEADER(type) ((type) & ~BNEP_EXT_HEADER)
>>
>
> Why not, but in this case, it would make sense to also define a macro
> for reading the extension bit
> Something like : #define BNEP_EXTENDED(type) ((type) & BNEP_EXT_HEADER)

Yep, anything that makes it more obvious what it is doing is a good
idea to have.


-- 
Luiz Augusto von Dentz
