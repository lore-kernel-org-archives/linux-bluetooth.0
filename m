Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKToJJ-g4W8YfPGWPBV-kn1NhqWPL2op7PabNoRj0tcJg@mail.gmail.com>
References: <CAHHBb0eePBK8bE3fkXJLdo5p1bhE42iOHxhwCiV1zgYvWg7k6g@mail.gmail.com>
 <CABBYNZKToJJ-g4W8YfPGWPBV-kn1NhqWPL2op7PabNoRj0tcJg@mail.gmail.com>
From: Dave Beal <dbeal@cardinalpeak.com>
Date: Thu, 16 Feb 2017 19:56:35 -0700
Message-ID: <CAHHBb0c6H7dkknUDgzen3bzEM7VTeBG9PZZYUROST3ozd2kBPA@mail.gmail.com>
Subject: Fwd: How to receive Notifications?
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thank you, Luiz.  My code is now able to receive notifications.  Is
there any way to register for *indications* in the current version of
BlueZ?


---------- Forwarded message ----------
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, Feb 14, 2017 at 11:17 AM
Subject: Re: How to receive Notifications?
To: Dave Beal <dbeal@cardinalpeak.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>


Hi Dave,

On Tue, Feb 14, 2017 at 2:28 AM, Dave Beal <dbeal@cardinalpeak.com> wrote:
> Hello -
>
> I'm using the GATT API of BlueZ 5.43 via libdbus.  I've successfully
> registered for notifications with the remote GATT server by calling
> the StartNotify method on the characteristic.  I know that the
> registration worked, because I see the remote server processing in.
> How does my GATT client code get informed when a notification arrives?

That should arrive as PropertiesChanged("Value", data) signals.


--
Luiz Augusto von Dentz
