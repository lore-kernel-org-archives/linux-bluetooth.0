Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2] frame reassembly implementation for data stream
From: Marcel Holtmann <marcel@holtmann.org>
To: Suraj <suraj@Atheros.com>
Cc: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Luis Rodriguez <Luis.Rodriguez@Atheros.com>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
In-Reply-To: <4C071A73.70407@Atheros.com>
References: <1275467080.13946.3.camel@atheros013-desktop>
	 <1275490955.2182.21.camel@localhost.localdomain>
	 <4C071A73.70407@Atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Jun 2010 23:38:07 -0700
Message-ID: <1275547087.2182.28.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

> > I don't like this implementation at all. The biggest problem is that you
> > are misusing __reassembly(hdev, HCI_ACLDATA_PKT) for getting your SKB. I
> > don't wanna intermix this. I am also missing checks for the packet
> > length matching or when packets are too big or the header size is not
> > matching up.
> >
> > So in theory both functions do exactly the same. Only minor exception is
> > that one knows the packet type up-front, the other has to read it from
> > the stream as a 1-byte header. I don't wanna maintain two functions that
> > do exactly the same.
> >
> > Creating an internal helper function that can maintain the current state
> > of the reassembly sounds a lot better. Then re-use that function and
> > ensure that the reassembly logic is inside the helper.
>
> I appreciate if you can take a closer look at the patch and compare it 
> with  hci_recv_fragment implementation.
> Eventhough it looks similar, there are major differences on the way data 
> is reassembled. It would not have worked if I had reused the same code 
> from  hci_recv_fragment().
> 
> Having a common reassembly helper could work. But I am not sure whether 
> that would be a better solution.

I did have a closer look at it already. I clearly see possibilities to
combine them into a more generic helper and not to maintain two
different functions that do exactly the same.

Regards

Marcel


