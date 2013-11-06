Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_MGVDvH4h71PgD6YWavOBm=xpgnh1nMtFNtEpL7gEQQcw@mail.gmail.com>
References: <1383729897-28492-1-git-send-email-johan.hedberg@gmail.com>
	<CAJdJm_MGVDvH4h71PgD6YWavOBm=xpgnh1nMtFNtEpL7gEQQcw@mail.gmail.com>
Date: Wed, 6 Nov 2013 09:32:58 -0400
Message-ID: <CAJdJm_Mj4AUHka3y5T1T=GEAATbuzwgsB20dLSMEzpdzi56jbA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Remove unnecessary 'send' parameter from smp_failure()
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi again,

On Wed, Nov 6, 2013 at 9:31 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Johan,
>
> On Wed, Nov 6, 2013 at 5:24 AM,  <johan.hedberg@gmail.com> wrote:
>
>> @@ -895,7 +895,7 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
>>                 break;
>>
>>         case SMP_CMD_PAIRING_FAIL:
>> -               smp_failure(conn, skb->data[0], 0);
>> +               smp_failure(conn, 0);
>
> I think you meant "smp_failure(conn, skb->data[0]);" here.

My bad, I see now that the purpose is to not send an error in this case.


-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
