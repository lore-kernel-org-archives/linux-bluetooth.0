Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Jan 2012 13:15:28 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/5] Add support for getting the Encryption Key
 Size via btio
Message-ID: <20120123111528.GG13100@x220>
References: <1323820654-16820-1-git-send-email-vinicius.gomes@openbossa.org>
 <20111215113720.GB6824@x220>
 <20111215191831.GA19354@samus>
 <CAJdJm_Pb+sVtXM4oiknUcJCubFejfKXzonov1qEh2fJhRxtUDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAJdJm_Pb+sVtXM4oiknUcJCubFejfKXzonov1qEh2fJhRxtUDw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Sun, Jan 22, 2012, Anderson Lizardo wrote:
> On Thu, Dec 15, 2011 at 3:18 PM, Vinicius Costa Gomes
> <vinicius.gomes@openbossa.org> wrote:
> > Hi Johan,
> >
> > On 13:37 Thu 15 Dec, Johan Hedberg wrote:
> >> Hi Vinicius,
> >>
> >> On Tue, Dec 13, 2011, Vinicius Costa Gomes wrote:
> >> > --- a/lib/bluetooth.h
> >> > +++ b/lib/bluetooth.h
> >> > @@ -63,6 +63,7 @@ extern "C" {
> >> >  #define BT_SECURITY        4
> >> >  struct bt_security {
> >> >     uint8_t level;
> >> > +   uint8_t key_size;
> >> >  };
> >> >  #define BT_SECURITY_SDP            0
> >> >  #define BT_SECURITY_LOW            1
> >>
> >> This libbluetooth change will need to be in a separate patch since it
> >> needs to be backported to hcidump (which now days has a copy of the lib).
> >
> > Sure.
> 
> I believe this series has not been applied yet due to this pending patch. Right?

Yes, that's correct.

Johan
