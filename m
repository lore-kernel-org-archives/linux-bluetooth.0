Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43FB39D8.3030908@gmail.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hci connect and switch role modifications
References: <loom.20051229T161453-986@post.gmane.org> <1135882032.5426.0.camel@localhost.localdomain>
In-Reply-To: <1135882032.5426.0.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------030308030308000201030705"
From: Capaianca <fcornevilli@gmail.com>
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
Date: Tue, 21 Feb 2006 17:03:36 +0100

This is a multi-part message in MIME format.
--------------030308030308000201030705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

   as requested, we have attached the unified diff files of our 
modifications. Basically, we added a couple mechanisms that may use to 
prevent some errors from occurring (error masking mechanisms). The 
mechanisms are part of the results of our research on bluetooth 
networks. Perhaps the same strategies  can  be  generalized and applied  
on several parts of the code in order to improve the overall robustness 
of the BlueZ stack.

Specifically, in the hci.c file (and related hci_lib.h) we added two 
functions that may help to solve some problems which may arise when 
creating connections or when switching the role. These functions are 
called "hci_create_connection_timed" and "hci_switch_role_checked".

The hci_create_connection_timed function first creates a connection and 
then checks whether the handle is valid (>0) until a given timeout 
expires. The timeout is specified as an additional parameter, in 
milliseconds.
We created this function because, while working with bluetooth, we 
noticed that to get a valid handle over a connection may take some time, 
even after that the hci_create_connection function return, due to the 
asynchronous nature of the connection creation process. This could 
result in a error when subsequent calls are performed over the 
connection with a handle that is still not valid (e.g. a bnep create 
connection call over an already created l2cap connection, or a switch 
role command). This function avoids this problem because it returns with 
no errors only if the created connection has a valid handle.
It is worth noting that the function returns a "timer expired (ETIME)" 
error even when the connection is created. This happens when the timeout 
expires but the connection still has a not valid handle. However, the 
handle could become valid after the function exits.

The hci_switch_role_checked function performs a similar task. During our 
tests we noticed that sometimes the hci_switch_role function exits with 
a EIO error even if the role was actually switched. This problem may be 
due to a temporary bad state of the rp.status value during the switch 
role process attempt. To overcome this problem, after an invalid check 
of rp.status value, our function reads the linkmode of the connection to 
check the real status after a little amount of time (100ms in the 
current version). If the role is not switched, further attempts are made 
until a timeout expires. This timeout is provided as an input parameter 
to our function.
This function resulted particularly useful when using PDA and other 
limited resources devices where the time required to perform the switch 
role may be longer and may result in errors signaled by the original 
hci_switch_role function even if the role was actually switched.


We preferred to provide two new functions rather than modifying the 
original ones. This way the user can choose to use the function that 
better suites his requirements.

In order to test and use the new functionalities, we also slightly 
modified the hcitool.c program, so as to add an optional parameter 
"--timeout" to both the "cc" and "sr" commands. If the parameter is 
specified the new functions are called, otherwise the original functions 
are used.

Hope this can be of interest and help the BlueZ community.

Best regards,
Marcello Cinque
Fabio Cornevilli
Mobilab Research Group - www.mobilab.unina.it

> Hi Marcello,
>
>   
>> we are working with Bluetooth and BlueZ since two years, and during the
>> development of a field failure data analysis of Bluetooth networks, we
>> experienced some annoying and frequent runtime errors that could be avoided.
>> Those errors concern the creation of a L2CAP connection via HCI and the role
>> switch operation. However, we discovered how to prevent these errors from
>> occurring, by adding a little amount of code in the hci_create_connection and
>> hci_switch_role functions in hci.c.   
>>
>> We would like to contribute to the development and let the community know and
>> evaluate these modifications.
>>
>> If you are interested, let us know what is the procedure to contribute.
>>     
>
> simply sent a unified diff against the latest CVS to the mailing list.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>   


--------------030308030308000201030705
Content-Type: application/gzip;
 name="diffiles.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="diffiles.tar.gz"

H4sIAAI6+0MAA+1ZbVPbSBLmq/gVU3xIbCw7kiz5DZxLykcCdQRSG3av7rJbKiGNsQpZEiOZ
wGb579fTo5HltwAbktTuTRfY0sx0T093z9M94/NoRn9PvdyftIJwPH6x9Q3IMGyj6zjwjbT8
jc+m0e52Om27a9pbhml17PYWcb6FMss0y3KPEbLFkiT/0rj7+v+idL7k/4kfulF43hKvTzOH
YRpGx7Y3+d+yOtL/lt1xoN102kZ3ixhPM/2X6f/c/81mk0ifJ6w10SzwVdOwmpZJTGdg9QZm
r2W2bdvqWV2LNLgvtxuNRsm0wmHBXwvc6nR6PbtXcLx6RZqOrXdIAz575NWrbRLGOQrJaBy4
jF7VeEMQ6CTL2cwXfdA8o1lOduFBR448nNJkltf3tslchM+ol1PXT+KY+nmYxKUsaAL288AL
AuaCHPGkkxkMMDvQkua3Ka28+9FlMh5nNBdtPWhi2acQ9kdl0O7Ei4OIFholoExjoyou1zj4
vgrJ72svCgPRxXWcGywIs0LDUrFSlhRVzka9LIkra60YPoyvZiG7FULotRsGYlxEC4Z4NnVZ
lsp1S5m7kZfyAcgNUsYJ2d0NQ51ESXxBxpF3kcFEPGh6PR40fUPvLgQNjX12m+YQgfHl/Uso
RlfXUPoLxl5QlONe0tvNslZZhRdclkS0ZFvvWDRjsj5gKlJAGepfVoLlYdLkN3JXFUw9dulO
k4B+2ULYMPVuwA85ZRAz1eYwrjSv2oDehPlD5lnlhLAKZPy4me/BRoHAX5CAkSK2Q8n/o/Hy
70Zr8n/Lf8Lcz+me/N8x2maZ/x3DhPG2bav8/12oyP889/vLmbw7MOyW0+l3TLNn2Yu5f2W0
Yw2MXqtvOX3T7ht2Je+bhoMgLr5txHGN0XzGYmIAItxBRmm82CWHoyMynsWYNUk+8SD3YTLN
iEfm+ZQAXk6gBdJN6FMC+EI+eWGekVmchxHw0QJ0SJgRTIAkYdi8kA9lIUFq9CZlNMtoACBD
plmrTqAlhKbdF3+BtL7d+Lzd0Oh1jrrBxzSNaE4JSyHHaBW1XT8lPjauqa/Y1VIHcvC8zIeA
H3g3/IVjUls04/6QGHXCddAoY3FChuTg6OSX18ecQ3q5afK3O6hAGtqUTmHVtWc+FAAGFHvh
7zQZ1/y0zpOidu756S3vbEkLim/shNb0Msc8QQQNhV1lJ6YRRlNMRtBp3BhW0edHiX/pCpMj
Y+mAYgAmYOEBIblwR7FyqTa7qqrNroTa7KqVXIwF3+nbN+7x0cm/3NHZsezzZd/ojTv66eD1
2YE7Oj05KbrpNQW/csv9cobt8PHu/fHB2UExwIcM601hwDPhQd4EJRaKrIhzR+/dD0f/lVys
5GKSi0mulZkkY9VDbMFDbNFDbK2HWKvwzpC8Hh2jHYRQHjkL1T7fNWhNSOtkH4JoOV4KJpa2
AKHzWbYSZaebQqzYNtyHaUs8y/gFO2c5TXls8KZPkxCKN2zZX9pYYjauQZj4eYT6AkK9PTjj
djs6eXOqk9oszsKLGKCD1611cA/DtRBczKJqFa3ASuX+ar6cKwiz1XbLfT0XgKpqsyyiNK2Z
mDPR2hpXvDGElj0C+MkxDpcCwAdt5Jz63iyjhHoQ0v6tz0HPu6SiE4CO4xu3GDdMadWzo3ci
fiq63z3R0WEbbEoQqwohi3CFuaJrmZgrut2+7vQekSvEboXVcTPwzYypQVTUGfk0odDO5p1g
I9Auim4lI18HZhBPltKPTBFPXcgLZF+QKhGcm7CYh59eCrD/alwXq0ZEfyigaw/AbLQ3Imoi
4nwtWr4/PT4a/WcdYH7499HZ6ND96fT4IXhYGf1IPBQsh69P3h5U2RbQuTJmKTE8LVou4RSe
qadrEEuEyhyr7ofYJVSSjMswuww3BBu/Cg6XZtai6QoW4jGcJ++9YroaHyQiRyq2iIoYhNod
oREg3edV1MTuPCGNIY9w8gLAr45oWUHFMIY6aQpezoo6kVtMtHogVbRFlHmxTxE0EXi5yCeF
XpHQNgLvtzrNC1QupUuU+dEHE0Xfhdac//MkiZ70DuCe879jOuX9v2OZHbz/dyx1/v8eVJz/
0efr7gD6A8tptXtdy7CtfmfxDkAEyvI9QG9gdlq9rt3v9ky7eg/Q7xq6CQ343RGl3WeyM6FR
uqNrBqbP55Pn5E4XHRz0ocMUHWzegWe+eU+KPQ3eU1RsO3rRlZdMQjz/4zXkHd5i84QX+lAj
QgDs+r7LNSFDGL7zc+Zd0MGv8c52U9v5Nfd98rHZ5PoMp39kv/EX1GEoj6PQti8S+0vO1Hgo
E7QVKg+nYRSFGYVkGCxJA30ObjxeKA+KVxQuxQVTUw8mbfh3iGEODGtgtAeGPTCcgdGpajOf
qw27bv3YuXCh+NpRVeNdJyFU2dPA9f2VXwE8duHrhXl34eW6LuKg18U7/V6/uNTXqsXwHn+X
dQSXUpzwiSbTXpLmsiYSiU/W6UPMmoSfGJKoOP/zBg1FwDsULO4/35nkj+KpXT458umw7D0s
ew+d4nBiGOJwYhi2bhpCd01OBmrBGj8av/GC5fn0OfkHxNqAoAKadg61xCVXDqoHn1cVEJsD
LFeW1+DlSVgTwsQpT/LyRy4roGNvFuUDlJsysAPUmyJ662IyUUNIpduG3udKt7u66RRK83v7
monD+ZGqWRaPqz+lYRUpq9dJnpxnNbRnXQc2rj82gal5nagXB5pnsiSxHN4sqk8YnkK1k7Da
zsiLn8v7vcrl3g6uGMq+RaPsl3dMf0pNrBofoScf/yBFq2XnRs2Km8Kn0E9fDPhHqwveRhWj
JKMu7FRQql4cqjFUTKOvA4o3TNOy9LYI8HKnF6dIiEx+5s6YK56yjxDwWEJuwPKvBWaYaSMw
Z6xESrLPLfYS4alR9N0Lr3MmzlNFWSliBf/ItNo9n8Bai6kk24SXGXsIXqJhy9sD8bC3BjE5
e8J/4QwCiY0ZW8XFccJcfibhvqvh+LkfdXLy8/FxHWcsrh0IH1PsvEXQqgrfBFjicLkJsQq3
rkMsswPwimHY6+hm9z7Iqv4Ou7DLxBbCE2xdYkgFgz6INSJ8ywuTsQfH64Bvl2ZlRoSk+ZIr
d95/Sofqhv2yEnxkRQs8Mq4DnXV3T5vU0OeRca9G+FuLXPYD1NPQOU34RIyp4MuPrnMVKVKk
SJEiRYoUKVKkSJEiRYoUKVKkSJEiRYoUKVKkSJEiRYoUKVKkSJEiRYr+LvQ/i8HwxgBQAAA=
--------------030308030308000201030705--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
