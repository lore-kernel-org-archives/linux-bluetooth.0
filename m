Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	=?iso-8859-1?Q?Fr=E9d=E9ric_Danis?=
	<frederic.danis@linux.intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 20 Oct 2011 16:27:40 +0200
Subject: RE: [PATCH v2 1/2] Simplify eir_parse function
Message-ID: <7769C83744F2C34A841232EF77AEA20C01DC6AB49D@dnce01.ent.ti.com>
References: <1319100817-8477-1-git-send-email-frederic.danis@linux.intel.com>
 <20111020111956.GA5742@fusion.localdomain>
In-Reply-To: <20111020111956.GA5742@fusion.localdomain>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan,Frederic,

> 
> 
> If there are multiple name tags in the EIR data you would leak here all
> of them except the last one (devices shouldn't have this but you can't
> control all sorts of crazy things people do). To keep the behavior as
> the existing code, free eir->name when encountering multiple tags and
> just keep the last one.
> 

The spec is very unspecific here (BT 4.0, Vol.3 Part C, section 11.1). Other than the Flags AD Data type which explicitly prohibits sending more than one, and the service solicitation AD type which implicitly limits it to one instance ("One of the Service Solicitation AD types may be sent to invite...."), all other AD Types are not limited in any way. A broadcaster/peripheral may send multiple instance of AD types. I'm not sure it is very clear how to handle two service AD types with different services, or handling two Full name AD types with different data. Maybe we should take a decision here to use the latest values advertised for those inconclusive AD Data types ?

Chen Ganir.

