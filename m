Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A9634D91F
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 06:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775198553; cv=none; b=qDr1wo+8K9yuLigDUjQRIjPObWfquEAkeELlyjytPdlW/MiUSPE2YV3Aqkyu12XnSQc/87wfwi7MSPha+MAvI4BlW//M5MrhLzC5nYNo7HHhbASiBjrFtOJwgvX/pW24HYP/4aWW4AwrxAaKyqqh6TtFbUpcNkh4ZuCoXzlJVVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775198553; c=relaxed/simple;
	bh=ZlN3Xcv//PGWhMaUUn2DCfcAjgqqDQavSOxaihwnDD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTDPStIi4SiwDTZQ5cXZxsTYV+f+BzILXSgD0gwgg2OOJCZYPGNJAgeh2IaZyU50cqbrxwHVuXm7o2mDPl10amA0Cnt1uUM+Zre+4WiLHRIhwqgWT8ni9c/L67xcLtHOVj1RBWxXwwGTrgxYw11sh0zgJkF+dG0xqFVCsTWxYdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oxqZpM++; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oxqZpM++"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=OKN7gDnzs2Kz4+KE1BtUeHkFkEQcEiFpWJ8XzlwW2hE=;
	b=oxqZpM++opknYomT0iaEFm78NNv3c2CzNNIoBG9TZf35QSGYdcPlIE2qTuNmGH
	4JYk7eQlFG9xMQYV1nHvcOWGXA8vkuJDrQaedajw5v6p22e7+yXNltg5mxO1RXvj
	kLLsU7f/Futf461VkKL8J64p2EFLQmz0F7Byl+0gn95Nw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXj6RIYc9pDiQbDA--.61841S2;
	Fri, 03 Apr 2026 14:42:17 +0800 (CST)
From: zhangchen200426@163.com
To: luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	zhangchen01@kylinos.cn,
	zhangchen200426@163.com
Subject: Re: [PATCH] [BlueZ,v1,1/1] avdtp: ignore Discover cmd when host sends before
Date: Fri,  3 Apr 2026 14:42:14 +0800
Message-Id: <20260403064214.1992828-1-zhangchen200426@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CABBYNZKVUyrKqu55jvOx2oTAgGN0D=Ff=W0K9nq2pVVii38Ovw@mail.gmail.com>
References: <CABBYNZKVUyrKqu55jvOx2oTAgGN0D=Ff=W0K9nq2pVVii38Ovw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXj6RIYc9pDiQbDA--.61841S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUUiSHUUUUU
X-CM-SenderInfo: x2kd0whfkh0jaqqujli6rwjhhfrp/xtbC6Am4VWnPYUniYAAA3A

On Thu, 2 Apr 2026 12:34:46 -0400, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> On Thu, Apr 2, 2026 at 3:58 AM <zhangchen200426@163.com> wrote:
> >
> > From: Zhang Chen <zhangchen01@kylinos.cn>
> >
> > Theoretically, the party that initiates the connection should send the DISCOVER
> > command. However, some devices, even though they are the connected party, still
> > send the DISCOVER command. In such cases, there is a probability of connection
> > failure.
> >
> > Fails:
> >
> > < ACL Data TX: Handle 10 flags 0x00 dlen 6
> >       Channel: 71 len 2 [PSM 25 mode Basic (0x00)] {chan 1}
> >       AVDTP: Discover (0x01) Command (0x00) type 0x00 label 4 nosp 0
> > > ACL Data RX: Handle 10 flags 0x02 dlen 8
> >       Channel: 64 len 4 [PSM 25 mode Basic (0x00)] {chan 1}
> >       AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 4 nosp 0
> >         ACP SEID: 1
> >           Media Type: Audio (0x00)
> >           SEP Type: SRC (0x00)
> >           In use: No
> > < ACL Data TX: Handle 10 flags 0x00 dlen 18
> >       Channel: 71 len 14 [PSM 25 mode Basic (0x00)] {chan 1}
> >       AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 5 nosp 0
> >         ACP SEID: 1
> >         INT SEID: 37
> >         Service Category: Media Transport (0x01)
> >         Service Category: Media Codec (0x07)
> >           Media Type: Audio (0x00)
> >           Media Codec: SBC (0x00)
> >             Frequency: 44100 (0x20)
> >             Channel Mode: Joint Stereo (0x01)
> >             Block Length: 16 (0x10)
> >             Subbands: 8 (0x04)
> >             Allocation Method: Loudness (0x01)
> >             Minimum Bitpool: 2
> >             Maximum Bitpool: 53
> > > ACL Data RX: Handle 10 flags 0x02 dlen 6
> >       Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 1}
> >       AVDTP: Set Configuration (0x03) Response Accept (0x02) type 0x00 label 5 >
> > > ACL Data RX: Handle 10 flags 0x02 dlen 6
> >       Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 1}
> >       AVDTP: Discover (0x01) Command (0x00) type 0x00 label 0 nosp 0
> > < ACL Data TX: Handle 10 flags 0x00 dlen 10
> >       Channel: 71 len 6 [PSM 25 mode Basic (0x00)] {chan 1}
> >       AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 0 nosp 0
> >         ACP SEID: 25
> >           Media Type: Audio (0x00)
> >           SEP Type: SNK (0x01)
> >           In use: No
> >         ACP SEID: 38
> >           Media Type: Audio (0x00)
> >           SEP Type: SRC (0x00)
> >           In use: No
> > < ACL Data TX: Handle 10 flags 0x00 dlen 7
> >       Channel: 71 len 3 [PSM 25 mode Basic (0x00)] {chan 1}
> >       AVDTP: Open (0x06) Command (0x00) type 0x00 label 6 nosp 0
> >         ACP SEID: 1
> > > ACL Data RX: Handle 10 flags 0x02 dlen 6
> >       Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 1}
> >       AVDTP: Open (0x06) Response Accept (0x02) type 0x00 label 6 nosp 0
> > < ACL Data TX: Handle 10 flags 0x00 dlen 12
> >       L2CAP: Connection Request (0x02) ident 5 len 4
> >         PSM: 25 (0x0019)
> >         Source CID: 65
> > > ACL Data RX: Handle 10 flags 0x02 dlen 12
> >       L2CAP: Disconnection Request (0x06) ident 5 len 4
> >         Destination CID: 64
> >         Source CID: 71
> > < ACL Data TX: Handle 10 flags 0x00 dlen 12
> >       L2CAP: Disconnection Response (0x07) ident 5 len 4
> >         Destination CID: 64
> >         Source CID: 71
> > > ACL Data RX: Handle 10 flags 0x02 dlen 16
> >       L2CAP: Connection Response (0x03) ident 5 len 8
> >         Destination CID: 127
> >         Source CID: 65
> >         Result: Connection refused - PSM not supported (0x0002)
> >         Status: No further information available (0x0000)
>
> You may consider throwing away the device you got, it is prefectly
> valid to have a discovery both ways, AVDTP does allows either way to
> setup a stream after all.
>
Both sides do have the ability to setup a streams. The AVDTP profile
has two roles, namely the initiator and the acceptor. The AVDTP
specification stipulates that the establishment of a stream is initiated
by the initiator, and the acceptor is the responding party. Therefore,
in a single connection, AVDTP streams should only be established by the
party that initiates the connection.
> > Works:
> >
> > < ACL Data TX: Handle 12 flags 0x00 dlen 6
> >       Channel: 77 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
> >       AVDTP: Discover (0x01) Command (0x00) type 0x00 label 11 nosp 0
> > > ACL Data RX: Handle 12 flags 0x02 dlen 8
> >       Channel: 64 len 4 [PSM 25 mode Basic (0x00)] {chan 0}
> >       AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 11 nosp 0
> >         ACP SEID: 1
> >           Media Type: Audio (0x00)
> >           SEP Type: SRC (0x00)
> >           In use: No
> > < ACL Data TX: Handle 12 flags 0x00 dlen 18
> >       Channel: 77 len 14 [PSM 25 mode Basic (0x00)] {chan 0}
> >       AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 12 nosp 0
> >         ACP SEID: 1
> >         INT SEID: 13
> >         Service Category: Media Transport (0x01)
> >         Service Category: Media Codec (0x07)
> >           Media Type: Audio (0x00)
> >           Media Codec: SBC (0x00)
> >             Frequency: 44100 (0x20)
> >             Channel Mode: Joint Stereo (0x01)
> >             Block Length: 16 (0x10)
> >             Subbands: 8 (0x04)
> >             Allocation Method: Loudness (0x01)
> >             Minimum Bitpool: 2
> >             Maximum Bitpool: 53
> > > ACL Data RX: Handle 12 flags 0x02 dlen 6
> >       Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
> >       AVDTP: Set Configuration (0x03) Response Accept (0x02) type 0x00 label 12>
> > > ACL Data RX: Handle 12 flags 0x02 dlen 6
> >       Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
> >       AVDTP: Discover (0x01) Command (0x00) type 0x00 label 0 nosp 0
>
> Yeah, and that just breaks the command sequence in the process, so
> this is a pretty bad idea if you ask me.
>
In this connection, the host acts as the initiator, so only the host needs
to send the discover command. The slave only needs to respond, and it is
unnecessary and unreasonable for the slave to send the discover command again.
This modification is to ignore the discover command sent by the slave in this
connection. If the slave acts as the initiator next time, this discover
command will not be ignored.
> > < ACL Data TX: Handle 12 flags 0x00 dlen 7
> >       Channel: 77 len 3 [PSM 25 mode Basic (0x00)] {chan 0}
> >       AVDTP: Open (0x06) Command (0x00) type 0x00 label 13 nosp 0
> >         ACP SEID: 1
> > > HCI Event: Number of Completed... (0x13) plen 5
> >         Num handles: 1
> >         Handle: 12
> >         Count: 1
> > > ACL Data RX: Handle 12 flags 0x02 dlen 6
> >       Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
> >       AVDTP: Open (0x06) Response Accept (0x02) type 0x00 label 13 nosp 0
> >
> > Signed-off-by: Zhang Chen <zhangchen01@kylinos.cn>
> > ---
> >  profiles/audio/avdtp.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> > index d475a545e..243c828bf 100644
> > --- a/profiles/audio/avdtp.c
> > +++ b/profiles/audio/avdtp.c
> > @@ -413,6 +413,8 @@ struct avdtp {
> >
> >         /* Attempt stream setup instead of disconnecting */
> >         gboolean stream_setup;
> > +
> > +       gboolean discover_start;
> >  };
> >
> >  static GSList *state_callbacks = NULL;
> > @@ -1418,6 +1420,11 @@ static gboolean avdtp_discover_cmd(struct avdtp *session, uint8_t transaction,
> >         struct seid_info *seps, *p;
> >         gboolean ret;
> >
> > +       if (session->discover_start) {
> > +               DBG("DISCOVER_CMD has been sent before.");
> > +               return TRUE;
> > +       }
> > +
> >         sep_count = queue_length(session->lseps);
> >
> >         if (sep_count == 0) {
> > @@ -2496,6 +2503,8 @@ struct avdtp *avdtp_new(GIOChannel *chan, struct btd_device *device,
> >          * with respect to the disconnect timer */
> >         session->stream_setup = TRUE;
> >
> > +       session->discover_start = FALSE;
> > +
> >         session->dc_timeout = DISCONNECT_TIMEOUT;
> >
> >         avdtp_connect_cb(chan, NULL, session);
> > @@ -3484,6 +3493,7 @@ int avdtp_discover(struct avdtp *session, avdtp_discover_cb_t cb,
> >         if (err == 0) {
> >                 session->discover->cb = cb;
> >                 session->discover->user_data = user_data;
> > +               session->discover_start = TRUE;
> >         } else if (session->discover) {
> >                 g_free(session->discover);
> >                 session->discover = NULL;
> > --
> > 2.25.1
> >
> >
>
>



-- 
Regards,
    Zhang Chen

