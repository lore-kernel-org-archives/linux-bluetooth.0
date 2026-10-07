Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C2C45D5C0
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791390277; cv=none; b=q31OTYqQzdK2ddUzq0e0GjOfDGDqgmu4AXzUkqZ3P2HMNd8uUlSvo7srFpYnxuHmgaeppF0w4IppuHeIfnjcvG95MfzTf3hWVazjdPmjU4SQZUn9jTVmqIsxPMmHkQotQo6rVPXcGUQli7pLx7+vX3xtMlPdVJ3aKbRd7i+iMds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791390277; c=relaxed/simple;
	bh=/PHLZF84Q3C+w0nDtL7MhrOpoqBMvJGrqTxsfwjfas8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CseJsgYfI3aSan8VptZ9P/JojrRx08dvj42X259DOJ68ZvTwaBvHZAJlKhDyj2zXB4JcSck6kvd7C8gpIKkwJh6L/xjBxQ6/aurKxrrg+chQlfxXcwgMWQYbLRMXTO5Oe0yXkrVKnEmfJn+A6EN3q6HTCLbeW2/i2w6vzaj+5kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=jj50NKa1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hYWVTrOW; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="jj50NKa1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hYWVTrOW"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AD6A41400140
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 12:24:34 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Wed, 07 Oct 2026 12:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791390274;
	 x=1791476674; bh=k83pZpePT/YqMsbVxGpW/a/YPJiQRIwF6Av7f3OJSvw=; b=
	jj50NKa1yFdNmvAFHJsjEENzT1l0un5Dq9FNxzxE1UTH2jktHK5F6hBE4U0YuzWz
	oZHDtdWMedw9fCPWQDnZFyRw8hjMLL7QQR1O8dLlvNV+GX0sI2VvNQpwqVDhtm8f
	+DmX72bnWSuP0qMBDk5s6YLEJnPjAisRQ2Ut8aCkdzVrx4+wBxlC1lOlb+4ndWEK
	PnoTWGRF53g8wgatjKy6iClCTa1GeAMV588WtW/iP8Ua1rb4QFyoLvPdhBoN8ejT
	LvakLg6mZpybs6lsNlcfFnly0M7Rly37G3KjDvhrNWddbGa5v3jlx4sfMtSYDEJ/
	UouZuiN2DbpGzGoIkgIwmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791390274; x=
	1791476674; bh=k83pZpePT/YqMsbVxGpW/a/YPJiQRIwF6Av7f3OJSvw=; b=h
	YWVTrOWcUAWYSCe28t48/M8kMJ5yTcLd9oY5MVj6Ewd53LnGLmNwtMgOObChb7on
	7k/sgknR4EGiTJ8sGWekEzJ05LtGgvekRjK9RUZza6Etb4vKqqJK9H6VB8srrFYS
	+xjO4TZPpuM81rpq6Llub/WQitcgxefVpLJkk4Gnx4dACF6oAwQk/GAjF1im2HOi
	osQTWE4QJB+nVoW7bwHUnw3pGkN8+jaEzLxL9rIBRHZkcoRs6dGTF7XMJ6IMaErz
	QyYYRYth+7DoCsQ+TWCf+VH5DR6qCjlJCSc+tqwtom0XGKsbgmmi8NS8C47J7+Nf
	SM5RPl0IaaU6H5vaRMBPA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791390274; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:pVehV88fK6943S22FfO3OG1hmpBigsEgxi6RlDDzKGtiFF0
	25pWhZd5dpIX5MeH9dpnKz7Dgn3gV8b37eEoYboYvu0CrbS24O27RhGa8THKRyCY
	Wvt8gyHbLnV46a2NTgYy9W0EiWPNHr2GAW6lQ+JI724fr93Q8IwWrIHi7DtpI6VP
	1BovGwLuV9VauApb1zA15K7eqp7oAduHMX4kIjnQF/DUXomakxuLbvoaDH3xp3Uo
	OiyZrz4bqLZRInTzTmYL7r9KllGQnNi/4Mkq8iBn/Y10HAXVsx+CaMnTuesih79Y
	v8YctcofF5qdG5EdFx+Em+uE+mRjj6K6OchUVJA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:sypOsXpvu02b2im0bVZvTlx90KMFyXNZ9KJP1CxUuXM=:/PHLZF84Q3C+w0nDtL7MhrOpoqBMvJGrqTxsfwjfas8=;
X-ME-Sender: <xms:QnLGahiVQVTBktTfCNriI5mfINJMH6bEaAsDgB46xVkceplc4i1K3Q>
    <xme:QnLGag3fjuk_6YK_t2owMw834cREzQ9dBcxTnPqTiS6JBa2cT1LFV0CbwOiNX74CA
    e_618LgCiUO6MsM9k9nbHyiZNvxr48FizZULgXresBBTnV8-kSlzb9Xeg>
X-ME-Proxy-Cause: dmFkZTG4XT59ics3ce198Ylpvy0UOdV7DaElEdNbYDlEqlmg9HBE3FcjjAtWREAIcTnxZ+
    4+Z04Cw7yJ9exw8dLtsJ18YKYEecW5lsGiwTltDzSIP+gn5p5k863RhskoBxXjdwxKTxip
    Ia05zrolOM5JdOxuGmFzzbgKS+rfj91GrxXXxuxyF22sk6cHdp13nHnaXduwW5ECgEleo0
    GSclJYfXFUBpRGanMtDC1+NpFwQJXQEOmghFcW9VE99jpH1W5/F6WhlfqI19KuBGhWliCb
    p3Z9zGnDRueNj7iWYLSUaR2+l+2kt+LbgVo7+JLO6JVeFFbfP4u18a6QpwkDHeVQ5sJsbD
    5MVkmFNaoW73nMUlm/Xlt7DtyB4FZIDI9foM8cFO4bIhmF8rjem8j+hosLr+hXnE2TM1xs
    5RUrbd49gAVchjNDdSZlF7f2NEZhEIePoEvHMvp25ruJuhPivMviJgjzfRlQB/ZhQ7xRaL
    vG67N8PfHDVj/im+EXwjlf8W8w6TWy1Y4y/Vf4yHV/UvIzl6Eh21/qs2yZjGly4FHNmHM2
    jmK4SJYzN0wRBwdrfXbAvRC/IRsEa97IC13M7129bJXLSUYLP2siwVEF3O4vyPnaHBuAg+
    YHUbRCyOhPIwyZDiNsUCVH++q/Y5QzDgnGnwOkbLNM7HSTXN9gggihFtjoow
X-ME-Proxy: <xmx:QnLGakNy-3ExkXV2BQ86I0e26pYqs4hWhIDArbqXULX9bCRFV6xGHA>
    <xmx:QnLGao4hVghTssB5kQasbUXSP8KzKP4NS1KRAp_7V6H3xO9-B0pPDA>
    <xmx:QnLGai1bgOvDzMCbTXfdPEJfMYDFHfwbhFBQdP7x2fI5BXsWRu8sAw>
    <xmx:QnLGapYrpUjC8bfhquLO6B5R5Xeyb-BkqXRd-VOygxEsJtDcPGDo-g>
    <xmx:QnLGapkR4KoKc7CNgdOc4pqntsI7Kz_sj8f3vyPuZDeV8XAhGb7xAZiz>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 87CA5216008A; Wed,  7 Oct 2026 12:24:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AG_b5Eg4e1Mc
Date: Wed, 07 Oct 2026 12:24:12 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1dd50f9a-1fc8-47e6-adc6-f868a4c19fab@app.fastmail.com>
In-Reply-To: 
 <CABBYNZKenK-vhhQXsS4PCB7zoEV8xyGvO77MiJ+V6dK-+7Y1Cw@mail.gmail.com>
References: <20261007144717.3832330-1-oss@fourdim.xyz>
 <CABBYNZKenK-vhhQXsS4PCB7zoEV8xyGvO77MiJ+V6dK-+7Y1Cw@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Reject signalling responses in invalid states
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, Oct 7, 2026, at 11:49 AM, Luiz Augusto von Dentz wrote:
> Hi Siwei,
>
> On Wed, Oct 7, 2026 at 10:47=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz> =
wrote:
>>
>> A peer can send configuration messages while an
>> incoming channel is in BT_CONNECT2, before the
>> security or deferred accept gate has completed. A
>> configuration response can then promote the channel
>> to BT_CONNECTED. Configuration responses can also
>> act on channels that are closing, and a late connection
>> response can move a disconnecting channel back to
>> BT_CONFIG.
>>
>> Accept connection responses only while waiting in
>> BT_CONNECT. Answer configuration requests in
>> BT_CONNECT2, but defer our own request until
>> BT_CONFIG so configuration cannot complete before
>> the gate. Ignore configuration responses outside
>> BT_CONFIG and BT_CONNECTED, and only complete
>> configuration in BT_CONFIG.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Cc: stable@vger.kernel.org
>> Assisted-by: Claude:claude-opus-5-5
>> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
>> ---
>> v3:
>>   - git lint on comments
>> v2: https://lore.kernel.org/linux-bluetooth/20260929154219.2366060-1-=
oss@fourdim.xyz/
>>   - resolve the patch conflict
>> v1: https://lore.kernel.org/linux-bluetooth/20260928173324.1837653-1-=
oss@fourdim.xyz/
>>
>>  net/bluetooth/l2cap_core.c | 20 +++++++++++++++++++-
>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index 49a998804908..cb4ec42f99e3 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -4438,6 +4438,10 @@ static int l2cap_connect_create_rsp(struct l2c=
ap_conn *conn,
>>
>>         lockdep_assert_held(&chan->conn->lock);
>>
>> +       /* Ignore a late response after the channel has left BT_CONNE=
CT. */
>> +       if (chan->state !=3D BT_CONNECT)
>> +               goto done;
>> +
>>         switch (result) {
>>         case L2CAP_CR_SUCCESS:
>>                 if (__l2cap_get_chan_by_dcid(conn, dcid)) {
>> @@ -4467,6 +4471,7 @@ static int l2cap_connect_create_rsp(struct l2ca=
p_conn *conn,
>>                 break;
>>         }
>>
>> +done:
>>         l2cap_chan_unlock(chan);
>>         l2cap_chan_put(chan);
>>
>> @@ -4604,7 +4609,13 @@ static inline int l2cap_config_req(struct l2ca=
p_conn *conn,
>>                 goto unlock;
>>         }
>>
>> -       if (!test_and_set_bit(CONF_REQ_SENT, &chan->conf_state)) {
>> +       /* A channel in BT_CONNECT2 has not passed security or usersp=
ace
>> +        * accept yet. Answer the peer's request, but hold our own un=
til
>> +        * the channel reaches BT_CONFIG: the CONNECT2 -> CONFIG site=
s send
>> +        * it. Connected channels may also need to reconfigure.
>> +        */
>> +       if ((chan->state =3D=3D BT_CONFIG || chan->state =3D=3D BT_CO=
NNECTED) &&
>> +           !test_and_set_bit(CONF_REQ_SENT, &chan->conf_state)) {
>>                 u8 buf[64];
>>                 l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CON=
F_REQ,
>>                                l2cap_build_conf_req(chan, buf, sizeof=
(buf)), buf);
>> @@ -4657,6 +4668,10 @@ static inline int l2cap_config_rsp(struct l2ca=
p_conn *conn,
>>
>>         lockdep_assert_held(&chan->conn->lock);
>>
>> +       /* Connected channels may also receive reconfiguration respon=
ses. */
>> +       if (chan->state !=3D BT_CONFIG && chan->state !=3D BT_CONNECT=
ED)
>> +               goto done;
>> +
>>         switch (result) {
>>         case L2CAP_CONF_SUCCESS:
>>                 l2cap_conf_rfc_get(chan, rsp->data, len);
>> @@ -4724,6 +4739,9 @@ static inline int l2cap_config_rsp(struct l2cap=
_conn *conn,
>>         if (test_bit(CONF_OUTPUT_DONE, &chan->conf_state)) {
>>                 set_default_fcs(chan);
>>
>> +               if (chan->state !=3D BT_CONFIG)
>> +                       goto done;
>> +
>>                 if (chan->mode =3D=3D L2CAP_MODE_ERTM ||
>>                     chan->mode =3D=3D L2CAP_MODE_STREAMING)
>>                         err =3D l2cap_ertm_init(chan);
>> --
>> 2.55.0
>
> Sashiko flagged a problem with these changes:
>
> https://sashiko.dev/#/patchset/20261007144717.3832330-1-oss%40fourdim.=
xyz
>

Hi Luiz,

Thank you for pointing this out. It is a valid bug.

That bug is already reachable without this patch.

For example, line 4719 l2cap_config_rsp in l2cap_core.c :

	if (flags & L2CAP_CONF_FLAG_CONTINUATION)
		goto done;

This line, which is just above my change, skips init as well.

I will send another patch to patch it because the fix will happen in
another function l2cap_parse_conf_rsp which is completely irrelevant.

Best,
Siwei

> --=20
> Luiz Augusto von Dentz
