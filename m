Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DCCC77B75
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 May 2023 20:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbjEVUip convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 May 2023 16:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbjEVUin (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 May 2023 16:38:43 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D780BB
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 May 2023 13:38:31 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 55462240101
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 May 2023 22:38:29 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QQ8RS5VrRz6tx9;
        Mon, 22 May 2023 22:38:28 +0200 (CEST)
Message-ID: <5f42d35bf0183db243f7cd577dc81a5322e61980.camel@iki.fi>
Subject: Re: [PATCH BlueZ 5/5] iso-tester: add tests for multiple
 simultaneous CIG
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Mon, 22 May 2023 20:38:28 +0000
In-Reply-To: <CABBYNZJDw5fNq9fQ7b29WBpEdAypsG_fazp5M_-7430r7YVpSA@mail.gmail.com>
References: <024df2d86c14fc811701ba27bfa576476bc9c0d6.1684682575.git.pav@iki.fi>
         <aa64f9c867330b2e691ee65ac30104b8757d7a4b.1684682575.git.pav@iki.fi>
         <CABBYNZJDw5fNq9fQ7b29WBpEdAypsG_fazp5M_-7430r7YVpSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

ma, 2023-05-22 kello 11:28 -0700, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
> 
> On Sun, May 21, 2023 at 8:32 AM Pauli Virtanen <pav@iki.fi> wrote:
> > 
> > Add tests connecting two CIS using different CIG_ID, with fixed and
> > auto-allocated IDs.
> > 
> > ISO Connect2 CIG 0x01/0x02 Seq - Success
> > ISO Connect2 CIG auto/auto Seq - Success
> > 
> > The CIS are connected sequentially so that the first is closed after the
> > second is connected. In the auto/auto case the kernel shall pick a new
> > CIG_ID since the first CIG_ID is no longer in a configurable state.
> 
> Is this somewhat similar to AC 7(i) but using different CIGs? I
> suspect this is not covered on BAP, although it is a valid audio
> configuration, perhaps we could use AC 7(i)-alt or something.

Yes, AC 6(ii) but with the CIS in separate CIGs. I'll change the name
then.

I think BAP only specifies audio configurations with a single CIG. This
seems to be valid configuration according to Core spec though, although
does not appear to be required.

> 
> > ---
> > 
> > Notes:
> >     The second tests hits a bug in kernel CIG auto-allocation, which always
> >     picks CIG_ID 0 even if it is not in a configurable state.
> > 
> >     ISO Connect2 CIG auto/auto Seq - Success - setup complete
> >     ISO Connect2 CIG auto/auto Seq - Success - run
> >       Connecting to 00:AA:01:01:00:00...
> >       Connect 0 in progress
> >       Connecting to 00:AA:01:02:00:01...
> >       Connect 1 in progress
> >       Successfully connected
> >       Step 1
> >       Connect failed: Device or resource busy (16)
> >       Expect error: Success (0) != Device or resource busy (16)
> > 
> >  tools/iso-tester.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> > 
> > diff --git a/tools/iso-tester.c b/tools/iso-tester.c
> > index 164cb465f..fc2a84215 100644
> > --- a/tools/iso-tester.c
> > +++ b/tools/iso-tester.c
> > @@ -64,6 +64,11 @@
> >                 QOS_IO(_interval, _latency, _sdu, _phy, _rtn), \
> >                 QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
> > 
> > +#define QOS_2(_interval, _latency, _sdu, _phy, _rtn) \
> > +       QOS_FULL(0x02, BT_ISO_QOS_CIS_UNSET, \
> > +               QOS_IO(_interval, _latency, _sdu, _phy, _rtn), \
> > +               QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
> > +
> >  #define QOS_1_1(_interval, _latency, _sdu, _phy, _rtn) \
> >         QOS_FULL(0x01, 0x01, \
> >                 QOS_IO(_interval, _latency, _sdu, _phy, _rtn), \
> > @@ -109,6 +114,7 @@
> >  #define QOS_16_1_1 QOS(7500, 8, 30, 0x02, 2)
> >  #define QOS_16_2_1 QOS(10000, 10, 40, 0x02, 2)
> >  #define QOS_1_16_2_1 QOS_1(10000, 10, 40, 0x02, 2)
> > +#define QOS_2_16_2_1 QOS_2(10000, 10, 40, 0x02, 2)
> >  #define QOS_1_1_16_2_1 QOS_1_1(10000, 10, 40, 0x02, 2)
> >  #define QOS_24_1_1 QOS(7500, 8, 45, 0x02, 2)
> >  #define QOS_24_2_1 QOS(10000, 10, 60, 0x02, 2)
> > @@ -546,6 +552,20 @@ static const struct iso_client_data connect_1_16_2_1 = {
> >         .expect_err = 0
> >  };
> > 
> > +static const struct iso_client_data connect_2_16_2_1 = {
> > +       .qos = QOS_1_16_2_1,
> > +       .qos_2 = QOS_2_16_2_1,
> > +       .expect_err = 0,
> > +       .mcis = true,
> > +};
> > +
> > +static const struct iso_client_data connect_2a_16_2_1 = {
> > +       .qos = QOS_16_2_1,
> > +       .qos_2 = QOS_16_2_1,
> > +       .expect_err = 0,
> > +       .mcis = true,
> > +};
> > +
> >  static const struct iso_client_data connect_1_1_16_2_1 = {
> >         .qos = QOS_1_1_16_2_1,
> >         .expect_err = 0
> > @@ -2126,6 +2146,25 @@ static void test_connect2(const void *test_data)
> >         setup_connect_many(data, 2, num, funcs);
> >  }
> > 
> > +static gboolean iso_connect2_seq_cb(GIOChannel *io, GIOCondition cond,
> > +                                                       gpointer user_data)
> > +{
> > +       struct test_data *data = tester_get_data();
> > +
> > +       data->io_id[0] = 0;
> > +
> > +       setup_connect(data, 1, iso_connect2_cb);
> > +
> > +       return iso_connect(io, cond, user_data);
> > +}
> > +
> > +static void test_connect2_seq(const void *test_data)
> > +{
> > +       struct test_data *data = tester_get_data();
> > +
> > +       setup_connect(data, 0, iso_connect2_seq_cb);
> > +}
> > +
> >  static void test_bcast(const void *test_data)
> >  {
> >         struct test_data *data = tester_get_data();
> > @@ -2264,6 +2303,15 @@ int main(int argc, char *argv[])
> >         test_iso("ISO QoS - Invalid", &connect_invalid, setup_powered,
> >                                                         test_connect);
> > 
> > +       test_iso2("ISO Connect2 CIG 0x01/0x02 Seq - Success", &connect_2_16_2_1,
> > +                                                       setup_powered,
> > +                                                       test_connect2_seq);
> > +
> > +       test_iso2("ISO Connect2 CIG auto/auto Seq - Success",
> > +                                                       &connect_2a_16_2_1,
> > +                                                       setup_powered,
> > +                                                       test_connect2_seq);
> > +
> >         test_iso_rej("ISO Connect - Reject", &connect_reject, setup_powered,
> >                         test_connect, BT_HCI_ERR_CONN_FAILED_TO_ESTABLISH);
> > 
> > --
> > 2.40.1
> > 
> 
> 

-- 
Pauli Virtanen
