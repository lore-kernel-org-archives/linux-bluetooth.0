Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20121212103614.GA7669@x220>
References: <ADCBF04BB97EBF4AAE65663F8478B61CA99E65AB92@Luna.iaSolution.net>
	<20121212075201.GA14256@x220>
	<ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABCC@Luna.iaSolution.net>
	<20121212092537.GA5371@x220>
	<ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABDA@Luna.iaSolution.net>
	<20121212100737.GA6620@x220>
	<ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABED@Luna.iaSolution.net>
	<20121212103614.GA7669@x220>
Date: Wed, 12 Dec 2012 06:58:41 -0400
Message-ID: <CAJdJm_NwzPpV_Js++uKWYsDzscJ5huUriWfv+JFEJNmapiJORw@mail.gmail.com>
Subject: Re: [BLE] org.bluez.Device1.Connect() returns org.bluez.Error.NotAvailable
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ting Chou <Ting.Chou@iasolution.net>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Dec 12, 2012 at 6:36 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> I agree that Device.Connect should at least work on devices that have
> been discovered but on whom we haven't completed service discovery yet.
> This would be analogous to the old Adapter.CreateDevice and it'd allow
> us to implement proper support for devices not supporting SMP (i.e.
> devices you can't call Device.Pair on). What remains to be discussed is
> whether Device.Connect is useful for LE devices in some more extended
> sense. Maybe it could at least force calling device_set_auto_connect().

On that matter, I would suggest (although I didn't spent much time
thinking on the consequences) that Device.Connect should add device to
auto connect list, and Device.Disconnect should disconnect current
connection and remove device from autoconnect list.

For devices which have services implemented inside BlueZ (e.g. HTP),
I'm not sure this is a good idea, because these profiles explicitely
state on their spec what should happen in case of disconnection, so it
is better to have BlueZ handle this for them (IMHO).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
