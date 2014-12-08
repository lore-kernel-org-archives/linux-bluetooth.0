Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <90BAB1E8-4E68-4F87-BB1B-B89687BE5E72@holtmann.org>
References: <1418046439-15725-1-git-send-email-jpawlowski@google.com>
	<90BAB1E8-4E68-4F87-BB1B-B89687BE5E72@holtmann.org>
Date: Mon, 8 Dec 2014 16:38:04 +0200
Message-ID: <CABBYNZKK9gHCKHvjSZBrn12KUTQefY7QpjPmO7=gNbxyJNgQPA@mail.gmail.com>
Subject: Re: [PATCH] doc/adapter-api.txt: StartServiceDiscovery method.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Jakub Pawlowski <jpawlowski@google.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, Jakub,

On Mon, Dec 8, 2014 at 4:07 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jakub,
>
>> This patch proposes new method, StartServiceDiscovery to D-Bus Adapter API for
>> desktop bluetoothd. It will allow for rapid discovery of nearby devices that
>> advertise services.
>>
>> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
>> ---
>> doc/adapter-api.txt | 20 ++++++++++++++++++++
>> 1 file changed, 20 insertions(+)
>>
>> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
>> index 74d235a..88533ed 100644
>> --- a/doc/adapter-api.txt
>> +++ b/doc/adapter-api.txt
>> @@ -22,6 +22,26 @@ Methods            void StartDiscovery()
>>                       Possible errors: org.bluez.Error.NotReady
>>                                        org.bluez.Error.Failed
>>
>> +             void StartServiceDiscovery(uint8 rssi, array{string} uuids)
>> +
>> +                     This method starts the device discovery session with
>> +                     filtering by uuids, and rssi value. Use StopDiscovery to
>> +                     release the sessions acquired.
>> +
>> +                     This method will use LE scan only.
>> +
>> +                     Device that have RSSI bigger than rssi parameter, and
>> +                     advertise at least one service from uuids array, is
>> +                     conseidered filter match.
>> +
>> +                     This process will start creating Device objects as new
>> +                     devices matching criteria are discovered. It will also
>> +                     emit PropertiesChanged signal for already existing
>> +                     Device objects, with updated RSSI value.
>> +
>> +                     Possible errors: org.bluez.Error.NotReady
>> +                                      org.bluez.Error.Failed
>> +
>
> I think we want to use an dictionary of filter properties here. Clearly the D-Bus API should provide the possibilities to filter out pathloss if we choose to. Additionally you might need an option to restrict this to only LE devices.

+1, btw have you guys discussed how to handle discovery started by
different processes? It would be good to allow but then we need to
resolve RSSI conflicts for the same UUIDs, anyway I guess it is fine
to receive signals from UUIDs not on its own list but perhaps it is a
good idea to document the behavior we want in such case so client
don't assume there could be only one session.



-- 
Luiz Augusto von Dentz
