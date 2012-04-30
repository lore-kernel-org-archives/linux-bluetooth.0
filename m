Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKNN4Fy4wrnWv45Kg1KdRddv3JdkmKK2ezpOVtXaVZdcQ@mail.gmail.com>
References: <1335561285-3332-1-git-send-email-lucas.demarchi@profusion.mobi>
 <CABBYNZKpoaxMXA--qbXqq=TDW69KcmP=Uiv9nacq2vJ0gTvMNQ@mail.gmail.com>
 <CAMOw1v4xkAgNkhMRmLP=Q6ffieL9fAS8Ej3uZEJv7tSp_sU3tg@mail.gmail.com> <CABBYNZKNN4Fy4wrnWv45Kg1KdRddv3JdkmKK2ezpOVtXaVZdcQ@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 30 Apr 2012 10:37:00 -0300
Message-ID: <CAMOw1v6O0nsSqx3drJrCtsAFB4Dm5st2ANVyKFdSLejp6m1AUg@mail.gmail.com>
Subject: Re: [BlueZ v3 00/10] gdbus: Better D-Bus introspection
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Apr 30, 2012 at 7:34 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lucas,
>
> On Mon, Apr 30, 2012 at 12:40 AM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>>
>> Since we are using '[' and ']' only internally. I don't see a problem
>> with that. If D-Bus start using it we can change later. Of course it's
>> better to convince D-Bus guys to reserve that, but IMO this shouldn't
>> be a blocker.
>>
>> From the chars you suggested, only '@' seems reasonable and I can
>> change to this char if we agree on it.
>
>  Either way IMO it is ugly to mess around with the signature but
> perhaps it is the only alternative we have.

There are other ways, but they have shortcomings, too -> the other 2
approaches that I sent to this ML have the shortcoming that in C it's
not possible to initialize flexible array members in a nested context.


>
> I wonder how other binding works in this regard, or they always have
> to depend on a xml file that describes the interface? iirc that used
> to be the case for GTK and QT, perhaps python is the only one that can
> really make use of this in runtime as d-feet seems to be able to use
> this information already.

As far as I checked, what glib does is to maintain the arguments in a
separate array (http://developer.gnome.org/gio/stable/gio-D-Bus-Introspection-Data.html#GDBusMethodInfo-struct).
This implies that for each method we need to declare the arguments in
a separate structure, not nested as we are doing now.


Lucas De Marchi
