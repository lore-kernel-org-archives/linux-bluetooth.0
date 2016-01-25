Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <241284aa107e466995c0821e4b015afd@FE-MBX1011.de.bosch.com>
References: <938d66c7e3ba4933912f948240b2669f@FE-MBX1011.de.bosch.com>
	<CABBYNZ+VyakQoiYV6=DkPux9ZCOB58BHRJGXU07UpxjzcJJr+Q@mail.gmail.com>
	<241284aa107e466995c0821e4b015afd@FE-MBX1011.de.bosch.com>
Date: Mon, 25 Jan 2016 13:54:12 +0200
Message-ID: <CABBYNZJcppMX8g7PXpVRd7hpg=4ogpWBkLYZR9YbON-Y1H67bA@mail.gmail.com>
Subject: Re: [BUG] LEAdvertisingManager suffers from ObjectManager hierarchy
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Kasper Markus (ETAS-PSC/ECE1)" <Markus.Kasper@escrypt.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Markus,

On Fri, Jan 22, 2016 at 5:43 PM, Kasper Markus (ETAS-PSC/ECE1)
<Markus.Kasper@escrypt.com> wrote:
> Hi Luiz,
>
>
>> -----Ursprüngliche Nachricht-----
>> Von: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
>> Hi Markus,
>>
>> On Thu, Jan 21, 2016 at 5:53 PM, Kasper Markus (ETAS-PSC/ECE1)
>> <Markus.Kasper@escrypt.com> wrote:
>> Actually LEAdvertisementManager1.RegisterAdvertisement does no actually
>> require ObjectManager, so the following shall probably work:
>>
>> iff --git a/src/advertising.c b/src/advertising.c index 59c8c3d..4b87d42 100644
>> --- a/src/advertising.c
>> +++ b/src/advertising.c
>> @@ -591,7 +591,7 @@ static struct advertisement
>> *advertisement_create(DBusConnection *conn,
>>                 return NULL;
>>
>>         ad = new0(struct advertisement, 1);
>> -       ad->client = g_dbus_client_new_full(conn, sender, path, path);
>> +       ad->client = g_dbus_client_new_full(conn, sender, path, NULL);
>>         if (!ad->client)
>>                 goto fail;
> I tried this solution --> works like a charm. Previously I fixed it by adapting the api to take path and rootpath (= obj. Manager path) and then added rootpath as the fourth parameter to the call above.
> But your fix is obviously much simpler. Will you commit it? You'd most likely be much faster than I am.

I was about to commit this but then I realize the code under
test/example-advertising does not actually uses ObjectManager and
still works, so even though GetManagedObjects does return an error the
code seems to cope with it just fine so Im not sure what exactly is
your bug?

>
>> > Re contributing:
> Thanks for clearing this up. The part in "HACKING" didn't mention both (user & kernel) and I missed the cleaner statement within the maintainers guidelines.
>> > Especially, the "how/where to commit/send?" is not really clear to me.
> What I read is: send patches formatted as text to this list (i.e. output of diff -Nurp).

The easiest method is to use git format-patch followed by git send-email.

-- 
Luiz Augusto von Dentz
