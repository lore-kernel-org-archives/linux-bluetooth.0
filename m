Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Dec 2012 09:48:50 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ting Chou <Ting.Chou@iaSolution.net>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [BLE] org.bluez.Device1.Connect() returns
 org.bluez.Error.NotAvailable
Message-ID: <20121213074850.GA1348@x220>
References: <20121212075201.GA14256@x220>
 <ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABCC@Luna.iaSolution.net>
 <20121212092537.GA5371@x220>
 <ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABDA@Luna.iaSolution.net>
 <20121212100737.GA6620@x220>
 <ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABED@Luna.iaSolution.net>
 <CAJdJm_Nb-W=ua7aUr7O578jJwLDGaC2-uC=vv0P2zdZOaXWUPg@mail.gmail.com>
 <ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABFC@Luna.iaSolution.net>
 <CAJdJm_PPnSmEV0nmjeka6vLa9qG9-FvZTvhypi9mfVyw+KxH+Q@mail.gmail.com>
 <ADCBF04BB97EBF4AAE65663F8478B61CA99E65AC43@Luna.iaSolution.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ADCBF04BB97EBF4AAE65663F8478B61CA99E65AC43@Luna.iaSolution.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ting,

On Thu, Dec 13, 2012, Ting Chou wrote:
> > > I'm not sure if I understand correctly. But do you mean the GCEP you
> > > mentioned above is applied while "reconnecting" to a supported device?
> > 
> > Yes, all GAP connection procedures are applicable for re-connection.
> > There is no "reconnection" procedure as per GAP (as far as I know).
> > But note that each GATT profile can specify reconnection procedures in
> > case of disconnection due to link loss (most of those that I read have
> > this). For instance, in HTP:
> > 
> > "5.2.4 Link Loss Reconnection Procedure
> > When a connection is terminated due to link loss, a Collector should
> > attempt to reconnect to the Thermometer using any of the GAP connection
> > procedures with the parameters in Table 5.2."
> > 
> > This is what BlueZ is doing for profiles implemented internally, except
> > that the parameters we use are not the ones recommended on the profile
> > specs (that could be implemented in future, but for now GCEP uses fixed
> > connection parameters).
> > 
> 
> So I should exercise the D-Bus API like following for LE device:
> 
>   Adapter1.StartDiscovery
>   Device1.Pair
>   ...
>   ...
>   // link loss
>   ...
>   // auto reconnect
>   ...
>   Adapter1.RemoveDevice
> 
> Is my understanding correct?

Yes, except that you should call Adapter1.StopDiscovery before calling
Device1.Pair.

Johan
