Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAu3APa3nWu_t+aRREFbQ3-VfLhJWLhgqmSadhMec57rbyw7SQ@mail.gmail.com>
References: <CAF6QkFKyKtJA-TVQnpDCb1inrSMXLkSd14WNJzRREAZbTnf-Ng@mail.gmail.com>
 <CAAu3APa3nWu_t+aRREFbQ3-VfLhJWLhgqmSadhMec57rbyw7SQ@mail.gmail.com>
From: "sayandasgupta12@gmail.com" <sayandasgupta12@gmail.com>
Date: Tue, 25 Apr 2017 21:53:15 +0530
Message-ID: <CAF6QkFKuZzGm=RbsukCQ9ZyQfR0J5aURc1TWEtWm4tFQg-nrhg@mail.gmail.com>
Subject: Re: SENDING GATT NOTIFICATION USING DBUS
To: Barry Byford <31baz66@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Barry,

I did look at it. But I want a solution in C and not python. I am not
conversant with Python. How do it convert this into C. I am a beginner
in bluez. Can you help me on this .

On Tue, Apr 25, 2017 at 7:59 PM, Barry Byford <31baz66@gmail.com> wrote:
> Hello,
>
> On 25 April 2017 at 11:43, sayandasgupta12@gmail.com
> <sayandasgupta12@gmail.com> wrote:
>> I am trying to send GATT notification in bluez 5.43 using DBUS. But
>> currently the gatt-service.c doesn't provide any details how to send
>> it using DBUS. Currently
>>
>> static DBusMessage *chr_start_notify(DBusConnection *conn, DBusMessage
>> *msg, void *user_data)
>>
>>     return g_dbus_create_error(msg, DBUS_ERROR_NOT_SUPPORTED, "Not Supported")
>>
>>
>> is given like this as no characteristic supports notification in the
>> given code. But I am trying to build a custom service which has
>> notifiable characteristics. How should i handle it. What should be the
>> code that i need to write inside char_start_notify to achieve it.
>
> Have you taken a look at test/example-gatt-server?
>
> The notifications are done with the PropertiesChanged signal on the
> value of the characteristic
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/gatt-api.txt#n121
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-gatt-server#n200
>
> And in the example are issued with:
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-gatt-server#n297
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-gatt-server#n399
>
> Hope that helps
>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
