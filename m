Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH BlueZ 00/14] Add TS Large Database, more server tests.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZKqoqSow2EfT52OdTgSipcN9GzwTFzYOGMGUf4Z2eowPQ@mail.gmail.com>
Date: Mon, 5 Jan 2015 13:23:35 -0800
Cc: Michael Janssen <jamuraa@chromium.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <5F9A5FF8-0C46-4DAA-9142-1D66D656BF1B@holtmann.org>
References: <1419985952-18334-1-git-send-email-jamuraa@chromium.org> <CABBYNZKqoqSow2EfT52OdTgSipcN9GzwTFzYOGMGUf4Z2eowPQ@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>> This patchset reworks the way that GATT test databases are defined,
>> defines a "large database" as defined by the test spec, adds a set
>> of new tests from the test spec.
>> 
>> It also includes some minor cleanup.
>> 
>> Michael Janssen (14):
>>  shared/gatt-db: Add gatt_db_find_by_type_value
>>  shared/gatt-server: support Discover by UUID
>>  unit/gatt: Bugfix small database construction
>>  unit/gatt: Add add_desc_with_value function
>>  unit/gatt: Rework service db definitions
>>  unit/gatt: Add Test Spec Large Database 1
>>  unit/gatt: Comment cleanup
>>  unit/gatt: Add /TP/GAD/SR/BV-02-C test
>>  unit/gatt: Add /TP/GAD/SR/BV-03-C test
>>  unit/gatt: Add /TP/GAD/SR/BV-04-C test
>>  unit/gatt: Add clarifying note about dup tests.
>>  unit/gatt: Add /TP/GAD/SR/BV-06-C test
>>  unit/gatt: Add /TP/GAR/SR/BV-01-C test
>>  unit/gatt: Add /TP/GAR/SR/BI-02-C test
>> 
>> src/shared/gatt-db.c     |  27 ++
>> src/shared/gatt-db.h     |   7 +
>> src/shared/gatt-server.c | 107 +++++++
>> unit/test-gatt.c         | 808 +++++++++++++++++++++++++++++++++++++++--------
>> 4 files changed, 812 insertions(+), 137 deletions(-)
>> 
>> --
>> 2.2.0.rc0.207.ga3a616c
> 
> I went ahead and applied patches 3-5, patch 6/14 does not apply:
> 
> Applying: unit/gatt: Add Test Spec Large Database 1
> WARNING:LONG_LINE: line over 80 characters
> #91: FILE: unit/test-gatt.c:961:
> + "11111222223333344444555556666677777888889999900000111112222233333444445555566666777778888899999000001111122222333334444455555666667777788888999990000011111222223333344444555556666677777888889999900000111112222233333444445555566666777778888899999000001111122222333334444455555666667777788888999990000011111222223333344444555556666677777888889999900000111112222233333444445555566666777778888899999000001111122222333334444455555666667777788888999990000011111222223333344444555556666677777888889999900000111112222233"),
> 
> WARNING:LONG_LINE: line over 80 characters
> #295: FILE: unit/test-gatt.c:1165:
> + "1111122222333334444455555666667777788888999"),
> 
> WARNING:LONG_LINE: line over 80 characters
> #306: FILE: unit/test-gatt.c:1176:
> + "22222333334444455555666667777788888999990000"),
> 
> WARNING:LONG_LINE: line over 80 characters
> #317: FILE: unit/test-gatt.c:1187:
> + "333334444455555666667777788888999990000011111"),

maybe it makes sense to split these over multiple lines. If it doesn't, then just force git am to ignore the warning and apply them anyway.

Regards

Marcel

