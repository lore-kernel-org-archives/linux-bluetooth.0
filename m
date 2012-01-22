Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111215191831.GA19354@samus>
References: <1323820654-16820-1-git-send-email-vinicius.gomes@openbossa.org>
	<20111215113720.GB6824@x220>
	<20111215191831.GA19354@samus>
Date: Sun, 22 Jan 2012 16:29:06 -0400
Message-ID: <CAJdJm_Pb+sVtXM4oiknUcJCubFejfKXzonov1qEh2fJhRxtUDw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] Add support for getting the Encryption Key Size
 via btio
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Dec 15, 2011 at 3:18 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> Hi Johan,
>
> On 13:37 Thu 15 Dec, Johan Hedberg wrote:
>> Hi Vinicius,
>>
>> On Tue, Dec 13, 2011, Vinicius Costa Gomes wrote:
>> > --- a/lib/bluetooth.h
>> > +++ b/lib/bluetooth.h
>> > @@ -63,6 +63,7 @@ extern "C" {
>> >  #define BT_SECURITY        4
>> >  struct bt_security {
>> >     uint8_t level;
>> > +   uint8_t key_size;
>> >  };
>> >  #define BT_SECURITY_SDP            0
>> >  #define BT_SECURITY_LOW            1
>>
>> This libbluetooth change will need to be in a separate patch since it
>> needs to be backported to hcidump (which now days has a copy of the lib).
>
> Sure.

I believe this series has not been applied yet due to this pending patch. Right?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
