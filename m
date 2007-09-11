Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 11 Sep 2007 18:00:35 +0200
From: "Marcus C. Gottwald" <gottwald@inf.fu-berlin.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20070911160035.GA21014@mi.fu-berlin.de>
References: <8c7950360709061306w39a081f1od1c372dafabc5072@mail.gmail.com>
	<1189451433.687.59.camel@violet>
	<8c7950360709101256u4a62893dmcd4b342343088a73@mail.gmail.com>
	<1189457819.687.89.camel@violet>
	<8c7950360709110512k1cede8e8r78b04b739de49ce4@mail.gmail.com>
	<1189523747.12789.25.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
In-Reply-To: <1189523747.12789.25.camel@aeonflux.holtmann.net>
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
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


Marcel Holtmann wrote (Tue 2007-Sep-11 17:15:47 +0200):

> You have to run a passkey agent. It takes care of asking for the PIN. A
> passkey agent however must not be interactive. It could always provide a
> default PIN. Write your own one if you need something special.

Note that when a German writes "must not" and it doesn't really
seem to make sense, he usually means "does not have to". This is
due to similar wording (but different meaning) used in the
German language. Same is true for "actual", which is often used
when the intended meaning is "current" or "prevailing".


Cheers, Marcus

-- =

   Marcus C. Gottwald  =B7  http://www.inf.fu-berlin.de/~gottwald/


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
