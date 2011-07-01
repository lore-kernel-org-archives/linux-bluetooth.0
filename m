Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <EC94610F2568494D8D9291885C48D3103D0DC8@nasanexd01a.na.qualcomm.com>
References: <1309419294-9903-1-git-send-email-nami.li@atheros.com>
	<BANLkTim8jj13o8zeRawV_QpT9+rp-afrbQ@mail.gmail.com>
	<EC94610F2568494D8D9291885C48D3103D08A1@nasanexd01a.na.qualcomm.com>
	<BANLkTi=YQcF-s+k2b26Rj5WeB--TOGsoHw@mail.gmail.com>
	<EC94610F2568494D8D9291885C48D3103D0DC8@nasanexd01a.na.qualcomm.com>
Date: Fri, 1 Jul 2011 09:52:19 +0300
Message-ID: <BANLkTim9SSkDPpaeQbADkFMBobC2nvXiag@mail.gmail.com>
Subject: Re: [PATCH obexd] Return correct obex service driver in obex_session_start
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Li, Nami" <nami@qca.qualcomm.com>
Cc: Slawomir Bochenski <lkslawek@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jul 1, 2011 at 5:50 AM, Li, Nami <nami@qca.qualcomm.com> wrote:
>
>
> -----Original Message-----
> From: Slawomir Bochenski [mailto:lkslawek@gmail.com]
> Sent: 2011年6月30日 18:26
> To: Li, Nami
> Cc: Luiz Augusto von Dentz; linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH obexd] Return correct obex service driver in obex_session_start
>
> On Thu, Jun 30, 2011 at 12:01 PM, Li, Nami <nami@qca.qualcomm.com> wrote:
>> Well, if the profile is OPP, then you can get correct service driver. But if the profile is FTP, because in ftp.c:
>>
>> static struct obex_service_driver ftp = {
>>        .name = "File Transfer server",
>>        .service = OBEX_FTP,
>>        .channel = FTP_CHANNEL,
>>        .psm = FTP_PSM,
>>        .record = FTP_RECORD,
>>        .target = FTP_TARGET,
>>        .target_size = TARGET_SIZE,
>>        .connect = ftp_connect,
>>        .get = ftp_get,
>>        .put = ftp_put,
>>        .chkput = ftp_chkput,
>>        .setpath = ftp_setpath,
>>        .disconnect = ftp_disconnect
>> };
>> It`s target is not null, target_size is 16, so " obex_service_driver_find(server->drivers, NULL,0, NULL, 0)" will return null.
>>
>> And I`m not picking up the first driver in the list, actually it is the only one in the list.
>
> In case of other profiles, there is OBEX connect command required, and then the appropriate driver will be selected in callback for OBEX connect event (see cmd_connect()).
>
> --
> Slawomir Bochenski
>
>
> Yep, you can get right diver after cmd_connect(). But I think user should get correct driver once obex session start, not after connect cmd. What if user want to use driver in obex_session_start() ? I need to use it when add OBEX over L2CAP.
> For OPP, it doesn`t register target and target size in opp.c. So when you call "obex_service_driver_find(server->drivers, NULL, 0, NULL, 0); ", it also returns on first and only list member:
>
>                                          if (memncmp0(target, target_size, driver->target,driver->target_size) == 0)                   return driver;
> which is actually ===>    if (memncmp0(NULL,0, NULL,0) == 0)                    return driver;
>
>
> So I think my patch is OK.

There is no guarantee that the opp will be the first in the list, nor
that the first driver will have no target which is consider the
default, so Im not sure why you are needing this for OBEX over L2CAP
since you still need to figure out what is the real driver on
connect_cmd. Also the sentence about the obex_session_start having to
get the correct driver makes no sense to me, we only know the target
on connect_cmd so we can only guess on obex_session_start that it is
an OPP session, or do you have a better default? Btw, if you are
planning to match the psm/channel with service driver, I believe that
is not a good idea since on some transports there could be no such
separation e.g. usb.

-- 
Luiz Augusto von Dentz
