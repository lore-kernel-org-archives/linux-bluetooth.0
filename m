Return-Path: <cyrus@holtmann.org>
Date: Sun, 19 Jun 2011 20:59:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Keith Packard <keithp@keithp.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Waldemar.Rymarkiewicz@tieto.com, padovan@profusion.mobi,
	marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Regression caused by "Bluetooth: Map sec_level to link key
 requirements"
Message-ID: <20110619175937.GA24188@dell.ger.corp.intel.com>
References: <yunboy7a2so.fsf@aiko.keithp.com>
 <99B09243E1A5DA4898CDD8B700111448175AA2DB2A@EXMB04.eu.tieto.com>
 <20110609083345.GA2894@dell.ccr.corp.intel.com>
 <yuny61b3pnm.fsf@aiko.keithp.com>
 <99B09243E1A5DA4898CDD8B700111448175AA2DE98@EXMB04.eu.tieto.com>
 <20110610055558.GA1832@dell>
 <BANLkTim4F8ZvWPMHSXpcBj9Eb2uFThcz4w@mail.gmail.com>
 <yun8vsynkiy.fsf@aiko.keithp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yun8vsynkiy.fsf@aiko.keithp.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Keith,

On Sun, Jun 19, 2011, Keith Packard wrote:
> On Fri, 10 Jun 2011 14:58:50 +0900, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> 
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 2f5ae53..b309f84 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -673,8 +673,8 @@ auth:
> >         if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend))
> >                 return 0;
> > 
> > -       hci_conn_auth(conn, sec_level, auth_type);
> > -       return 0;
> > +       if (!(hci_conn_auth(conn, sec_level, auth_type)))
> > +               return 0;
> > 
> >  encrypt:
> >         if (conn->link_mode & HCI_LM_ENCRYPT)
> 
> That makes the first connection afer boot succeed, but subsequent
> connections fail in the same way.

Did you try also the following patch (which should also be making it to
3.0):
http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-2.6.git;a=commitdiff;h=330605423ca6eafafb8dcc27502bce1c585d1b06

I think you'll need both of them to fix the pairing/security issues.

Johan
