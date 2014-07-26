Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <CEBE7999-B96C-421B-99EC-BDD4F8B5F56D@holtmann.org>
References: <1406326123-10564-1-git-send-email-armansito@chromium.org>
	<1406326123-10564-4-git-send-email-armansito@chromium.org>
	<6DBCE20A-3015-4B1D-A4AC-B3DF786D2D58@holtmann.org>
	<CAHrH25TVTc1mo02dvX-B3ggrUJy9MmYvKWk1xuLpevzr-435=A@mail.gmail.com>
	<CEBE7999-B96C-421B-99EC-BDD4F8B5F56D@holtmann.org>
Date: Sat, 26 Jul 2014 15:10:34 -0700
Message-ID: <CAHrH25TEteB7GN+3C9WfZXJCpESdihMsXgZyJpow7k47hLN7WQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] shared/gatt: Implement "Discover All Primary
 Services" procedure.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

All of what you just mentioned is pretty much what I've had in mind,
so that's great. I'm currently only focusing on bt_gatt_client
initially and the helpers that I'm currently adding will be internally
used by it. I'm also planning to add a command-line tool and build PTS
style tests based on the helpers and bt_att directly.

My intention is that bt_gatt_client will handle all of the GATT
service discovery magic, as well as service changed events, caching,
etc. for us and provide simple API functions to enable/disable
notifications etc. Then, in the BlueZ daemon we can create a D-Bus API
layer and revise the plugins entirely to access all attributes through
the core bt_gatt_client instance.

So yeah, I think we're thinking in the same direction here :)

Cheers,
Arman

On Sat, Jul 26, 2014 at 1:54 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Arman,
>
>>> I think we need to fix bt_att_send to return false when we got disconne=
cted in between the individual commands. I did run some tests with the code=
 here and if we receive a disconnect, we get stuck and the callback is neve=
r called. So when we have running longer procedures, we need to handle the =
cases where we loose the connection in the middle of it.
>>>
>>
>> I'm actually aware of this issue and was trying to decide who is
>> responsible for handling disconnects. I'm guessing that bt_att can use
>> io_set_disconnect_handler to crate a handler for this case, in which I
>> guess the right thing to do is to mark the bt_att structure as
>> invalidated, cancel all pending ATT operations, and perhaps notify the
>> user with a special callback (similar to the timeout callback)? The
>> user will then have to create a new connection and pass the fd to
>> bt_att_new to obtain a new instance.
>
> I think for now we need to make sure the bt_att internally detects the di=
sconnect and sets itself an internal state as disconnected. So besides call=
ing any configured disconnect callback, we have to make sure that the trans=
port is marked as invalid. And in case it is invalid all future bt_att_send=
 should return false. That is just the basic and should make sure that the =
bt_gatt_* helpers will call their callback with a failed status.
>
> That said, my general direction here is that I want to get to having bt_g=
att as main functionality handling the details of everything GATT related.
>
>         struct bt_gatt_server;
>
>         struct bt_gatt_server *bt_gatt_server_new(struct bt_att *att, str=
uct bt_gatt_db *db);
>
>         struct bt_gatt_client;
>
>         struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att);
>
> Both of these can use the same bt_att transport and will just carry out a=
ny functionality we need. The server should take care of needed notificatio=
ns on new connections and the client should handle caching properly. Maybe =
the GATT helpers you are currently working will be converted to become an a=
ctual expose functionality of bt_gatt_client in the long run.
>
> In addition to these two fine grained server and client control structs, =
I want the magic do everything for us and do it correct bt_gatt support. Me=
aning it will listen for incoming or auto-connect connections and also prov=
ided outgoing connections.
>
>         struct bt_gatt;
>
>         struct bt_gatt *bt_gatt_new(void);
>
> But this is something we most likely should do last and focus on GATT cli=
ent and server support first. If they can share the same bt_att and we have=
 that working smoothly, the rest should fall into place all by itself.
>
> On a side note, this is how I am currently restructuring SDP as well. The=
 only difference is that SDP server and SDP client do not share a transport=
. You can only be one role. So that talks directly to a file descriptor ins=
tead of a transport abstraction like bt_att. Otherwise it is exactly the sa=
me.
>
> This would mean that long term a GAP implementation just has to instantia=
te one bt_sdp and one bt_gatt and after that everything GAP related is take=
n care of.
>
> If you want a view along the road, then the step after that is bt_gap tha=
t will include bt_sdp, bt_gatt and also handle mgmt. At that point we shoul=
d be able to run the whole Bluetooth core functionality for BlueZ and also =
BlueZ for Android from exactly the same code base. The only difference will=
 be then that Android only supports one controller and BlueZ will actually =
support many controllers. So the difference is the number of bt_gap instanc=
es.
>
> Anyway, maybe this is a bit too much right now anyway. My point is that I=
 do not have an exact map on how to get there. I just know where we need to=
 get to. The details we have to figure out along way. That is also why I st=
arted testing your code with some of my peripherals that I have lying aroun=
d. So it might be good that some point soon you start adding ATT and GATT u=
nit tests. Preferable also some that actually match what PTS is testing. I =
think you can derive some inspiration from AVDTP, AVRCP or SDP test cases. =
I think ATT should be dead simple to test using a socketpair (with a specia=
l hack for the MTU exchange).
>
> Regards
>
> Marcel
>
