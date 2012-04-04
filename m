Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120404122217.GA15085@x220>
References: <1333539940-29061-1-git-send-email-vishal.agarwal@stericsson.com>
	<20120404115301.GA5081@x220>
	<CA+_sZW9cqfW4Nz0C21av25VzwkSTat6QW6FoWGDzcA=oezgGLg@mail.gmail.com>
	<20120404122217.GA15085@x220>
Date: Wed, 4 Apr 2012 18:02:17 +0530
Message-ID: <CA+_sZW-55fFpgKo5RU9g3cmubSqF270DW_TS=RUxWyS0zkwmqg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Temporary keys should be retained during connection
From: vishal agarwal <vishal.bluez@gmail.com>
To: vishal agarwal <vishal.bluez@gmail.com>,
	Vishal Agarwal <vishal.agarwal@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Apr 4, 2012 at 5:52 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Vishal,
>
> On Wed, Apr 04, 2012, vishal agarwal wrote:
>> > Firstly, did you verify that this fixes your test case? You still
>> > didn't tell us what test case this is, btw.
>
> What about the above?
>
Yes with this PTS testcase is passing now, the testcase which was failing
earlier TC_PSE_SSM_BI_02_C (test case for PBAP server)

>> > Since setting the flag is outside of mgmt.c I think the removal should
>> > also be. That way you also avoid an extra call to
>> > hci_conn_hash_lookup_ba. I.e. please put the removal in
>> > hci_disconn_complete_evt.
>> >
>> > I'd also still like to hear your opinion of the second option I
>> > proposed. If you had a reference to struct link_key in hci_conn then
>> > you'd just need to call list_del() and nothing else to remove it (i.e.
>> > no iteration of hdev->link_keys necessary.
>>
>> If I implement it this way then there will be two new variables added,
>> one in hci_conn to store the reference of key and other one is inside
>> link_key structure to store if key is temporary or not.
>> or you want me to store reference of key to hci_conn only when the key
>> is temporary?
>> in this case also code might become complicated to handle cases if key
>> is re generated and new key is not temporary but the older one was.
>>
>> So in my opinion after the changes you suggested (moving code in
>> hci_disconn_complete_evt), this is also OK. lesser and clearer code.
>
> Ok, fair enough. The hci_disconn_complete_evt change should be enough
> then.
>
> Johan

Vishal
