Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid patch (patch 00.13)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051011104238.GA29541@localhost.localdomain>
References: <e1effdeb0510060731s191b17bbrd52897af77622ba6@mail.gmail.com>
	 <1128784148.5212.17.camel@blade>
	 <e1effdeb0510081605p56bcd8fcob8fcd77f616c105d@mail.gmail.com>
	 <1128896442.19569.26.camel@blade>
	 <20051010195850.GA23080@localhost.localdomain>
	 <1128977357.7352.1.camel@blade>
	 <20051011100057.GA29401@localhost.localdomain>
	 <1129025702.7352.17.camel@blade>
	 <20051011104238.GA29541@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1129031528.5681.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 11 Oct 2005 13:52:08 +0200

Hi Johan,

> > I applied your patch and the compiler on my 64-bit machine is much
> > happier now, but I think that we need to allocate a structure and pass
> > the pointer to it around instead of some casting tricks. Would you mind
> > fixing it?
> 
> I'm not really sure what you mean. Is there some other information
> besides the device id that needs to be passed around (i.e. what should
> go into this struct)? If we start using allocated structs it means that
> a lot of the memory handling stuff that my first patch removed needs to
> go back.

I know, but this is the only clean way. The casts are a little bit too
ugly. However since hcid is only a playfield for the the D-Bus support,
I think we can live with it. For bluetoothd this code will be too ugly,
but we might change it anyhow and use or own event loop implementation.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
