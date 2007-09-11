Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <8c7950360709110512k1cede8e8r78b04b739de49ce4@mail.gmail.com>
References: <8c7950360709061306w39a081f1od1c372dafabc5072@mail.gmail.com>
	<1189451433.687.59.camel@violet>
	<8c7950360709101256u4a62893dmcd4b342343088a73@mail.gmail.com>
	<1189457819.687.89.camel@violet>
	<8c7950360709110512k1cede8e8r78b04b739de49ce4@mail.gmail.com>
Date: Tue, 11 Sep 2007 17:15:47 +0200
Message-Id: <1189523747.12789.25.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] devices always connect with out asking for
	PIN	even with pairing enabled!
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Shane,

> Then if comment out all the options in the hcid.conf, hcid should then
> use all its default values and I should be able to do the pairing and
> security completely with PAND, correct?

use the default hcid.conf. It has sane settings. And yes, pand will
control the request for authentication.

> A passkey agent is used to send the key when requested by the master
> but then how do you set the passkey on the master.  I was originally
> using passkey in the hcid.conf file but that goes against your
> recommendation of never touching the hcid.conf file.  Were does the
> master PIN get set?  Does it also just use a passkey agent?

You have to run a passkey agent. It takes care of asking for the PIN. A
passkey agent however must not be interactive. It could always provide a
default PIN. Write your own one if you need something special.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
