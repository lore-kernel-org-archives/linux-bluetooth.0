Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTimoeb9NAsuN3QS+UP1P2obYhY7rj+D-Ww4G1+QV@mail.gmail.com>
References: <1299765690-16322-1-git-send-email-epx@signove.com>
	<AANLkTimoeb9NAsuN3QS+UP1P2obYhY7rj+D-Ww4G1+QV@mail.gmail.com>
Date: Thu, 10 Mar 2011 10:48:02 -0400
Message-ID: <AANLkTi=Z_KhyJV-Nj4kiR_zL55ttvL+CiMYYW+Ky6W8F@mail.gmail.com>
Subject: Re: [PATCH v4] Implement ATT handle indications
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Mar 10, 2011 at 10:16 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> Hi Elvis,
>
> Is it allowed to have notification and indication bits set to the same
> characteristic?
> If it is not allowed you could simplify the logic inside the "for".

The spec does not forbid both indication and notification to be
enabled, as Elvis mentioned.
>> +               /* Indication */
>> +               if (g_slist_find_custom(channel->indicate,
>> +                                       GUINT_TO_POINTER(handle), handle_cmp)) {
>> +                       uint8_t pdu[ATT_MAX_MTU];
>> +                       uint16_t len;
>
> The same declarations(pdu and len) exist  for Notification. I suggest
> move to the outer scope.

Actually, it was a suggestion from Johan to move these declarations to
inner scope. But at the time there was only one if() statement, which
justified this.

Anyway, patch is applied, so this can be made into a simple refactor
if you find it better to put in outer scope.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
