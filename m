Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_N9e+7pfcsxBFWSMrv-97rq8GcnMZ0gVi_Z-c-i-pT7UQ@mail.gmail.com>
References: <1316113131-10944-1-git-send-email-anderson.lizardo@openbossa.org>
	<20110916103553.15662dyub01c99wk@mail.hendrik-sattler.de>
	<CAJdJm_N9e+7pfcsxBFWSMrv-97rq8GcnMZ0gVi_Z-c-i-pT7UQ@mail.gmail.com>
Date: Fri, 16 Sep 2011 09:15:57 -0400
Message-ID: <CAJdJm_N_9tdCea=DhKu9s=YUm6TRKDKBgQ-bMRp3CHOLAqMZpQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Fix allocation of attribute values
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Hendrik Sattler <post@hendrik-sattler.de>
Cc: linux-bluetooth@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hendrik,

On Fri, Sep 16, 2011 at 7:05 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
>>>                memcpy(a->data, value, vlen);
>>
>> And here you do...hmm...hard to tell since the pointer now shows to...where?
>> Even if that pointer is valid and is assigned the right size memory, you
>> just leaked memory.

After some thought (and thanks to Johan over IRC), I now see which
issue you are referring to. I'm reviewing all other places where this
bug might happen as well. Unfortunately, looks like it slipped through
manual review and valgrind altogether :(

Thanks,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
