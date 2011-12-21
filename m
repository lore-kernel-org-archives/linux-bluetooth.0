Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111221113330.GC21295@aemeltch-MOBL1>
References: <1324438330-9887-1-git-send-email-ulisses@profusion.mobi>
	<1324438330-9887-2-git-send-email-ulisses@profusion.mobi>
	<20111221113330.GC21295@aemeltch-MOBL1>
Date: Wed, 21 Dec 2011 09:52:00 -0200
Message-ID: <CAA37ikYmY7BHQkg7mKOeFZL656OazNRcooJSTwozQ9SDotOxQQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: Make HCI call directly into SCO and
 L2CAP event functions
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Ulisses Furquim <ulisses@profusion.mobi>,
	linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Dec 21, 2011 at 9:33 AM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi Ulisses,
>
> On Wed, Dec 21, 2011 at 01:32:10AM -0200, Ulisses Furquim wrote:
>> The struct hci_proto and all related register/unregister and dispatching
>> code was removed. HCI core code now call directly the SCO and L2CAP
>> event functions.
>>
>> Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
>> ---
>>  include/net/bluetooth/hci_core.h |  125 ++++++++++++-------------------------
>>  net/bluetooth/hci_core.c         |   59 +-----------------
>>  net/bluetooth/l2cap_core.c       |   51 ++-------------
>>  net/bluetooth/sco.c              |   38 +----------
>>  4 files changed, 56 insertions(+), 217 deletions(-)
>
> ...
>
>>  static inline int hci_proto_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
>>                                                               __u8 type)
>>  {
>> -     register struct hci_proto *hp;
>> -     int mask = 0;
>> -
>> -     hp = hci_proto[HCI_PROTO_L2CAP];
>> -     if (hp && hp->connect_ind)
>> -             mask |= hp->connect_ind(hdev, bdaddr, type);
>> +     if (type == ACL_LINK)
>> +             return l2cap_connect_ind(hdev, bdaddr);
>> +     else if (type == SCO_LINK || type == ESCO_LINK)
>> +             return sco_connect_ind(hdev, bdaddr);
>
> The patch looks OK though I think it is better to use switch instead of
> "else if"s in your code.

Ok, Marcel also said that. It's been a while since I touch this code
and forgot the preferences. :-)

> Best regards
> Andrei Emeltchenko

Best regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
