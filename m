Return-Path: <cyrus@holtmann.org>
Date: Tue, 19 Jan 2010 10:02:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] HFP support into oFono and BlueZ
Message-ID: <20100119080223.GA20493@jh-x301>
References: <fbf08281001110908s2c3412m456b3aa980b8ca10@mail.gmail.com>
	<fbf08281001131539l342a3062w70883c197dc52983@mail.gmail.com>
	<2d5a2c101001180338n2a37f0e9y76942650b755166@mail.gmail.com>
	<201001171637.22263.denkenz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201001171637.22263.denkenz@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, ofono@ofono.org
Reply-To: ofono@ofono.org
List-Unsubscribe: <http://lists.ofono.org/options/ofono>,
	<mailto:ofono-request@ofono.org?subject=unsubscribe>
List-Archive: <http://lists.ofono.org/pipermail/ofono>
List-Post: <mailto:ofono@ofono.org>
List-Help: <mailto:ofono-request@ofono.org?subject=help>
List-Subscribe: <http://lists.ofono.org/listinfo/ofono>,
	<mailto:ofono-request@ofono.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: ofono-bounces@ofono.org
Errors-To: ofono-bounces@ofono.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Denis,

On Sun, Jan 17, 2010, Denis Kenzior wrote:
> > having it as a MediaEndpoint I guess it is probably a good idea to
> > have a similar design as we will have in endpoints, so the
> > registration actually happen in adapter path rather than device path,
> > which probably should avoid the having to resolve the device path
> > while probing if we just send the device path as a parameter of
> > NewConnection so we can do while in DEFER_SETUP stage so we don't risk
> > missing or getting timeouts while transferring the the fd to ofono.
> 
> Personally I like this to be a per-device agent rather than per-adapter as it 
> will make agent code inside oFono a bit easier to write.  Marcel / Johan, care 
> to weigh in?

My initial gut feeling is that this should be adapter based, though that
might be partly fueled by the fact that that's also how the current
pairing and authorization agent is designed. However, I do remember us
discussing this earlier and the outcome back then was (at least based on
your API suggestion) to have a per-device agent. I can't remember the
exact supporting arguments for this, but at least the API does get
simpler since then we don't need a new interface for both adapter and
device objects and the parameter lists of the HandsfreeAgent interface
methods become shorter since we don't need to have the remote device
object path there.

Johan
_______________________________________________
ofono mailing list
ofono@ofono.org
http://lists.ofono.org/listinfo/ofono
