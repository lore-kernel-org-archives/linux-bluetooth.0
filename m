Return-Path: <cyrus@holtmann.org>
From: <Michal.Labedzki@tieto.com>
To: <luiz.dentz@gmail.com>, <vani.patel@stericsson.com>
CC: <linux-bluetooth@vger.kernel.org>, <Joohi.rastogi@stericsson.com>,
	<vani273@gmail.com>
Date: Mon, 13 Aug 2012 14:49:32 +0300
Subject: RE: [PATCH BlueZ V5 1/5] AVRCP: Add TG Record to support AVRCP
 Browsing
Message-ID: <E50901D4F2CF69428D43141B7C8586792CF109BB8B@EXMB03.eu.tieto.com>
References: <1344591300-1003-1-git-send-email-vani.patel@stericsson.com>,<CABBYNZLMLCpfd_GzUMvtND6m0JJsuKLDCiyzvQAZkBrsV5U7vw@mail.gmail.com>
In-Reply-To: <CABBYNZLMLCpfd_GzUMvtND6m0JJsuKLDCiyzvQAZkBrsV5U7vw@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,


>> diff --git a/audio/avrcp.c b/audio/avrcp.c
>> index d925365..ca40c1e 100644
>> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
>> @@ -190,7 +190,7 @@ static sdp_record_t *avrcp_ct_record(void)
>>         sdp_list_t *aproto, *proto[2];
>>         sdp_record_t *record;
>>         sdp_data_t *psm, *version, *features;
>> -       uint16_t lp = AVCTP_PSM;
>> +       uint16_t lp = AVCTP_CONTROL_PSM;
>>         uint16_t avrcp_ver = 0x0100, avctp_ver = 0x0103;
>>         uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
>>                                                 AVRCP_FEATURE_CATEGORY_2 |
>> @@ -252,13 +252,15 @@ static sdp_record_t *avrcp_ct_record(void)
>>
>>  static sdp_record_t *avrcp_tg_record(void)
>>  {
>> -       sdp_list_t *svclass_id, *pfseq, *apseq, *root;
> +       sdp_list_t *svclass_id, *pfseq, *apseq, *root, *apseq_browsing;
>>         uuid_t root_uuid, l2cap, avctp, avrtg;
>>         sdp_profile_desc_t profile[1];
>>         sdp_list_t *aproto, *proto[2];
>>         sdp_record_t *record;
>> -       sdp_data_t *psm, *version, *features;
>> -       uint16_t lp = AVCTP_PSM;
>> +       sdp_data_t *psm, *version, *features, *psm_browsing;
>> +       sdp_list_t *aproto_browsing, *proto_browsing[2] = {0};
>> +       uint16_t lp = AVCTP_CONTROL_PSM;
>> +       uint16_t lp_browsing = AVCTP_BROWSING_PSM;
>>         uint16_t avrcp_ver = 0x0104, avctp_ver = 0x0103;
>>         uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
>>                                         AVRCP_FEATURE_CATEGORY_2 |

>According to the spec if we register the browsing channel we should
>set it in feature bits, btw apparently apseq_browsing is leaking
>please make sure you run your patches with valgrind/gdb to catch this
>type of errors.
>
>--
>Luiz Augusto von Dentz

According to the specification we should not expose browsing in feature bits:
"*4: Bit 6 (Browsing supported) is not set based on category. Bit 6 in the SDP record shall only be set if
browsing of the "Media Player Virtual Filesystem" is supported."

So no GetFolderItems on VFS scope - no browsing.


Regards / Pozdrawiam
-------------------------------------------------------------------------------------------------------------
Micha³ £abêdzki
ASCII: Michal Labedzki
e-mail: michal.labedzki@tieto.com
office communicator: michal.labedzki@tieto.com
location: Poland, Wroc³aw, Legnicka 55F
room: 420
phone: +48 717 740 340
---
Tieto Corporation / Tieto Poland
http://www.tieto.com / http://www.tieto.pl
---
Tieto Poland spó³ka z ograniczon± odpowiedzialno¶ci± z siedzib± w Szczecinie, ul. Malczewskiego 26. Zarejestrowana w S±dzie Rejonowym Szczecin-Centrum w Szczecinie, XIII Wydzia³ Gospodarczy Krajowego Rejestru S±dowego pod numerem 0000124858. NIP: 8542085557. REGON: 812023656. Kapita³ zak³adowy: 4 271500 PLN
________________________________________

