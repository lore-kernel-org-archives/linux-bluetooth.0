Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <EC94610F2568494D8D9291885C48D3103D08A1@nasanexd01a.na.qualcomm.com>
References: <1309419294-9903-1-git-send-email-nami.li@atheros.com>
	<BANLkTim8jj13o8zeRawV_QpT9+rp-afrbQ@mail.gmail.com>
	<EC94610F2568494D8D9291885C48D3103D08A1@nasanexd01a.na.qualcomm.com>
Date: Thu, 30 Jun 2011 12:25:44 +0200
Message-ID: <BANLkTi=YQcF-s+k2b26Rj5WeB--TOGsoHw@mail.gmail.com>
Subject: Re: [PATCH obexd] Return correct obex service driver in obex_session_start
From: Slawomir Bochenski <lkslawek@gmail.com>
To: "Li, Nami" <nami@qca.qualcomm.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jun 30, 2011 at 12:01 PM, Li, Nami <nami@qca.qualcomm.com> wrote:
> Well, if the profile is OPP, then you can get correct service driver. But if the profile is FTP, because in ftp.c:
>
> static struct obex_service_driver ftp = {
>        .name = "File Transfer server",
>        .service = OBEX_FTP,
>        .channel = FTP_CHANNEL,
>        .psm = FTP_PSM,
>        .record = FTP_RECORD,
>        .target = FTP_TARGET,
>        .target_size = TARGET_SIZE,
>        .connect = ftp_connect,
>        .get = ftp_get,
>        .put = ftp_put,
>        .chkput = ftp_chkput,
>        .setpath = ftp_setpath,
>        .disconnect = ftp_disconnect
> };
> It`s target is not null, target_size is 16, so " obex_service_driver_find(server->drivers, NULL,0, NULL, 0)" will return null.
>
> And I`m not picking up the first driver in the list, actually it is the only one in the list.

In case of other profiles, there is OBEX connect command required, and
then the appropriate driver will be selected in callback for OBEX
connect event (see cmd_connect()).

-- 
Slawomir Bochenski
