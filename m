Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1449353589.29155.35.camel@jkn0.kehl.dalim.com>
References: <1449350482.29155.23.camel@jkn0.kehl.dalim.com>
	<CAExxLLDwut0z6WV-HroU9wuGvQ5hvtAXrWc-yu_dAFn5BLJE4Q@mail.gmail.com>
	<1449353589.29155.35.camel@jkn0.kehl.dalim.com>
Date: Sun, 6 Dec 2015 12:59:56 +0100
Message-ID: <CAExxLLAicQSJLbcd0+UL4SZynkJYzzWJoJVUJaB1CUrLmLrBKg@mail.gmail.com>
Subject: Re: read data from a BLE device using gatt-client
From: =?UTF-8?Q?=C5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>
To: jacques klein <jacques.klein@dalim.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Dec 5, 2015 at 11:13 PM, jacques klein <jacques.klein@dalim.com> wrote:
>
> On Sat, 2015-12-05 at 22:54 +0100, Łukasz Rymanowski wrote:
>
> Hi Jacques,
>
> On Sat, Dec 5, 2015 at 10:21 PM, jacques klein <jacques.klein@dalim.com> wrote:
> > Hello,
> >
> > I am currently writing a small Bluez-5.35 Linux app to interact with a
> > BLE device.
> > I used as starting point and example the code in btgatt-client.c and
> > most things work.
> >
> > But I have trouble to find out how to implement the "reading of data
> > sent" by the device after having sent the command "REQUEST_THIS_DATA".
> > Things are working because I can see the data displayed by the
> > att_debug_cb function.
> >
> > # my (added) function
> > [GATT client]# request-day-prog <device> <day>
> > [GATT client]# att: ATT op 0x12
> > [GATT client]# att: < 12 11 04 20
> > 04                                   ... .
> > [GATT client]# att: >
> > 13                                               .
> > [GATT client]# att: ATT response received: 0x13
> > [GATT client]#
> > Write successful
> > # displayed by att_debug_cb, it's ok, the bytes make sense.
> > [GATT client]# att: > 1b 21 04 21 04 22 24 2a 36 22 66 2a 8a 22 90
> > 22  .!.!."$*6"f*."."
> > [GATT client]# att:   90 22
> > 90                                         .".
> > [GATT client]# att: ATT PDU received: 0x1b
> >
> > what I don't know, is what I have to setup ( call some
> > bt_att_register_????() ? )
> > in order for a callback function of my app. to be called.
> >
> > Any pointer to  example, documentation, or even google search keywords
> > will be appreciated.
> > ( I don't want to go into DBUS or Python,  just stay with simple C
> > calling bt_att_... and/or bt_gatt_... functions )
> >
> >
>
> I'm not sure what is you goal. Anyway, data which has been sent you
> can see with btmon tool
>
>
> Thanks for such a quick reply,
>
> No problem to see the data being sent back from the device after I have sent it the
> command to request the data, not a reliability problem either.
> It is a pure lack of knowledge about how to program the framework provided by the bt_att and
> bt_gatt APIs.
>
> As I told it, my program receives and "sees" the data, but in the
>
>    static void att_debug_cb(const char *str, void *user_data) {
>        .....
>    }
>
> which is given to the framework with
>
>     bt_att_set_debug(cli->att, att_debug_cb, (void *)"att: ", NULL);
>
> What I am looking for is a similar function to call in order to for a
> a callback function I defined in my program to be called
> with the data buffer as argument once it has been got.
>

Ah so you are hacking around. Look what gatt-server does in order to
handle received data.
Normally you should create your database with services and
characteristics, then let gatt_server
to manage it (handle client browsing, read/write requests etc)

> If your application wants to make sure what data has been sent to
> remote then you might want
> to check reliable session which uses prepare/execute write.
>
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>

-- 
BR / Pozdrawiam
Łukasz
