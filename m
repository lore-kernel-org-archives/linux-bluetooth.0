Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110810093029.GA21443@dell>
References: <1312931140-9143-1-git-send-email-bulislaw@linux.com>
	<20110810093029.GA21443@dell>
Date: Wed, 10 Aug 2011 11:31:32 +0200
Message-ID: <CAPGrrxV6bOoKVVFSLVaXbq25ND=JwR4Xn261gb1frz-gOfEP-g@mail.gmail.com>
Subject: Re: [PATCH obexd 1/2] Fix memory issues in EDS PBAP
From: Bartosz Szatkowski <bulislaw@linux.com>
To: Bartosz Szatkowski <bulislaw@linux.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Aug 10, 2011 at 11:30 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Bartosz,
>
> On Wed, Aug 10, 2011, Bartosz Szatkowski wrote:
>> ---
>>  plugins/phonebook-ebook.c |   19 +++++++++++++------
>>  1 files changed, 13 insertions(+), 6 deletions(-)
>
> Both patches have been applied. Thanks.
>
> I additionally pushed a cleanup patch to phonebook-ebook.c since there
> were quite a lot of coding style issues in it as well as GError misuse
> (you always need to initialize them to NULL).
>
> Johan
>

Thanks.

-- 
Pozdrowienia,
Bartosz Szatkowski
