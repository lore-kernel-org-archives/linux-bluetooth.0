Return-Path: <cyrus@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH 3/3] a2dp: avoid conversion between guint and pointers
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Date: Wed, 16 Nov 2011 15:35:12 +0100
From: Hendrik Sattler <post@hendrik-sattler.de>
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>,
	<linux-bluetooth@vger.kernel.org>
In-Reply-To: <CABBYNZLS-FdozoGBwujyPsWw310NQbbuCy84H1SedbCzJ_bvXQ@mail.gmail.com>
References: <4EC3B375.8090203@bmw-carit.de>
 <CABBYNZLS-FdozoGBwujyPsWw310NQbbuCy84H1SedbCzJ_bvXQ@mail.gmail.com>
Message-ID: <bd30ff802e6d226c2211eeb7fb91b51c@mail.hendrik-sattler.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 16.11.2011 14:43, schrieb Luiz Augusto von Dentz:
>>  static void endpoint_open_cb(struct a2dp_sep *sep, guint setup_id,
>>                                                               
>>  gboolean ret)
>>  {
>> -       struct a2dp_setup *setup = GUINT_TO_POINTER(setup_id);

> Im not really convinced that this can cause problems, Ive never seems
> a crash caused by this and if we were to change anything than I would
> simply revert the parameter back to void * so we don't have to create
> an array for pending setups.

Deriving a pointer from a smaller type is definitely wrong.
Actually, GUINT_TO_POINTER and GPOINTER_TO_UINT are used the wrong way 
around, here.

HS

