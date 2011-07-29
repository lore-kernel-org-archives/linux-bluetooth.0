Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110729100719.GB3880@dell>
References: <1311758618-23826-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<20110729100719.GB3880@dell>
Date: Fri, 29 Jul 2011 19:59:56 +0300
Message-ID: <CABBYNZK0gFv7uDvhaOLw0TvbqVBMOa0XBSp4p9_Z9tqkK7AMEQ@mail.gmail.com>
Subject: Re: [PATCH] hcidump: decode extended flow spec option
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Jul 29, 2011 at 1:07 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Andrei,
>
> On Wed, Jul 27, 2011, Emeltchenko Andrei wrote:
>> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>>
>> Decode EFS option in l2cap configuration packets
>> ---
>>  parser/l2cap.c |   52 ++++++++++++++++++++++++++++++++++++++++++++--------
>>  1 files changed, 44 insertions(+), 8 deletions(-)
>
> Applied. Thanks.
>
> Johan
> --

I think we might want to check the version of libbluetooth, otherwise
this might fail to compile with older version.

-- 
Luiz Augusto von Dentz
