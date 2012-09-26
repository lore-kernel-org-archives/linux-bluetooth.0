Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJPxL3TgD6NA69Q-QCSCxgssM2E5xULnvTPntUAWLc_kw@mail.gmail.com>
References: <3176460F0F455A44B2E93431E34FC86C228F881F31@EXDCVYMBSTM005.EQ1STM.local>
	<CABBYNZJPxL3TgD6NA69Q-QCSCxgssM2E5xULnvTPntUAWLc_kw@mail.gmail.com>
Date: Wed, 26 Sep 2012 20:24:42 +0300
Message-ID: <CABBYNZ+9xD7R2VbTddL5TG5PXpdxbYEsYKT1vhkk7TG9h-UjRA@mail.gmail.com>
Subject: Re: [PATCH BlueZ V7 1/5] AVRCP: Add TG Record to support AVRCP Browsing
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Joohi RASTOGI <joohi.rastogi@stericsson.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joohi,

On Fri, Sep 21, 2012 at 12:23 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Joohi,
>
> On Fri, Sep 21, 2012 at 8:22 AM, Joohi RASTOGI
> <joohi.rastogi@stericsson.com> wrote:
>> From 7348afc3401746a1890763ac5b689fca164fd934 Mon Sep 17 00:00:00 2001
>> From: Joohi Rastogi <joohi.rastogi@stericsson.com>
>> Date: Thu, 20 Sep 2012 14:21:37 +0530
>> Subject: [PATCH BlueZ V7 1/5] Adds SDP record to support browsing
>>
>> ---
>>  audio/avctp.c |    4 ++--
>>  audio/avctp.h |    3 ++-
>>  audio/avrcp.c |   30 +++++++++++++++++++++++++-----
>>  3 files changed, 29 insertions(+), 8 deletions(-)
>>
>> diff --git a/audio/avctp.c b/audio/avctp.c
>> index 4e0e8dc..20aed66 100644
>> --- a/audio/avctp.c
>> +++ b/audio/avctp.c
>> @@ -803,7 +803,7 @@ static GIOChannel *avctp_server_socket(const bdaddr_t *src, gboolean master)
>>         io = bt_io_listen(NULL, avctp_confirm_cb, NULL,
>>                                 NULL, &err,
>>                                 BT_IO_OPT_SOURCE_BDADDR, src,
>> -                               BT_IO_OPT_PSM, AVCTP_PSM,
>> +                               BT_IO_OPT_PSM, AVCTP_CONTROL_PSM,
>>                                 BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
>>                                 BT_IO_OPT_MASTER, master,
>>                                 BT_IO_OPT_INVALID);
>> @@ -1091,7 +1091,7 @@ struct avctp *avctp_connect(const bdaddr_t *src, const bdaddr_t *dst)
>>         io = bt_io_connect(avctp_connect_cb, session, NULL, &err,
>>                                 BT_IO_OPT_SOURCE_BDADDR, &session->server->src,
>>                                 BT_IO_OPT_DEST_BDADDR, &session->dst,
>> -                               BT_IO_OPT_PSM, AVCTP_PSM,
>> +                               BT_IO_OPT_PSM, AVCTP_CONTROL_PSM,
>>                                 BT_IO_OPT_INVALID);
>>         if (err) {
>>                 avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
>> diff --git a/audio/avctp.h b/audio/avctp.h
>> index d0cbd97..9d19b5d 100644
>> --- a/audio/avctp.h
>> +++ b/audio/avctp.h
>> @@ -22,7 +22,8 @@
>>   *
>>   */
>>
>> -#define AVCTP_PSM 23
>> +#define AVCTP_CONTROL_PSM              23
>> +#define AVCTP_BROWSING_PSM             27
>>
>>  #define AVC_MTU 512
>>  #define AVC_HEADER_LENGTH 3
>> diff --git a/audio/avrcp.c b/audio/avrcp.c
>> index 27be7e8..206d8fa 100644
>> --- a/audio/avrcp.c
>> +++ b/audio/avrcp.c
>> @@ -106,6 +106,7 @@
>>  #define AVRCP_FEATURE_CATEGORY_3       0x0004
>>  #define AVRCP_FEATURE_CATEGORY_4       0x0008
>>  #define AVRCP_FEATURE_PLAYER_SETTINGS  0x0010
>> +#define AVRCP_FEATURE_BROWSING                 0x0040
>>
>>  #define AVRCP_BATTERY_STATUS_NORMAL            0
>>  #define AVRCP_BATTERY_STATUS_WARNING           1
>> @@ -191,7 +192,7 @@ static sdp_record_t *avrcp_ct_record(void)
>>         sdp_list_t *aproto, *proto[2];
>>         sdp_record_t *record;
>>         sdp_data_t *psm, *version, *features;
>> -       uint16_t lp = AVCTP_PSM;
>> +       uint16_t lp = AVCTP_CONTROL_PSM;
>>         uint16_t avrcp_ver = 0x0100, avctp_ver = 0x0103;
>>         uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
>>                                                 AVRCP_FEATURE_CATEGORY_2 |
>> @@ -253,18 +254,20 @@ static sdp_record_t *avrcp_ct_record(void)
>>
>>  static sdp_record_t *avrcp_tg_record(void)
>>  {
>> -       sdp_list_t *svclass_id, *pfseq, *apseq, *root;
>> +       sdp_list_t *svclass_id, *pfseq, *apseq, *root, *apseq_browsing;
>>         uuid_t root_uuid, l2cap, avctp, avrtg;
>>         sdp_profile_desc_t profile[1];
>>         sdp_list_t *aproto, *proto[2];
>> -       sdp_record_t *record;
>> -       sdp_data_t *psm, *version, *features;
>> -       uint16_t lp = AVCTP_PSM;
>> +       sdp_record_t *record;sdp_data_t *psm, *version, *features, *psm_browsing;
>> +       sdp_list_t *aproto_browsing, *proto_browsing[2] = {0};
>> +       uint16_t lp = AVCTP_CONTROL_PSM;
>> +       uint16_t lp_browsing = AVCTP_BROWSING_PSM;
>>         uint16_t avrcp_ver = 0x0104, avctp_ver = 0x0103;
>>         uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
>>                                         AVRCP_FEATURE_CATEGORY_2 |
>>                                         AVRCP_FEATURE_CATEGORY_3 |
>>                                         AVRCP_FEATURE_CATEGORY_4 |
>> +                                       AVRCP_FEATURE_BROWSING |
>>                                         AVRCP_FEATURE_PLAYER_SETTINGS );
>>
>>         record = sdp_record_alloc();
>> @@ -295,6 +298,17 @@ static sdp_record_t *avrcp_tg_record(void)
>>
>>         aproto = sdp_list_append(0, apseq);
>>         sdp_set_access_protos(record, aproto);
>> +       proto_browsing[0] = sdp_list_append(0, &l2cap);
>> +       psm_browsing = sdp_data_alloc(SDP_UINT16, &lp_browsing);
>> +       proto_browsing[0] = sdp_list_append(proto_browsing[0], psm_browsing);
>> +       apseq_browsing = sdp_list_append(0, proto_browsing[0]);
>> +
>> +       proto_browsing[1] = sdp_list_append(0, &avctp);
>> +       proto_browsing[1] = sdp_list_append(proto_browsing[1], version);
>> +       apseq_browsing = sdp_list_append(apseq_browsing, proto_browsing[1]);
>> +
>> +       aproto_browsing = sdp_list_append(0, apseq_browsing);
>> +       sdp_set_add_access_protos(record, aproto_browsing);
>>
>>         /* Bluetooth Profile Descriptor List */
>>         sdp_uuid16_create(&profile[0].uuid, AV_REMOTE_PROFILE_ID);
>> @@ -307,6 +321,12 @@ static sdp_record_t *avrcp_tg_record(void)
>>
>>         sdp_set_info_attr(record, "AVRCP TG", 0, 0);
>>
>> +       free(psm_browsing);
>> +       sdp_list_free(proto_browsing[0], 0);
>> +       sdp_list_free(proto_browsing[1], 0);
>> +       sdp_list_free(apseq_browsing, 0);
>> +       sdp_list_free(aproto_browsing, 0);
>> +
>>         free(psm);
>>         free(version);
>>         sdp_list_free(proto[0], 0);
>> --
>> 1.7.5.4

These patches are now upstream, but I had to spend quite sometimes
fixes things that apparently wasn't tested properly. Im also working
on redesigning some pieces to makes things saner again, I hope next
time I don't have to spend so much time fixing so many things again.


-- 
Luiz Augusto von Dentz
