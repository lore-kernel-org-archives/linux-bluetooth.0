Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <b7f7accd0710162048k790a1d69tac577730fed6bb6e@mail.gmail.com>
Date: Wed, 17 Oct 2007 09:18:27 +0530
From: "Yogesh Jagtap" <jagtapyb@gmail.com>
To: Bluez-users@lists.sourceforge.net
In-Reply-To: <b7f7accd0710160552x6d6e8a49h9646911eb2a94bf8@mail.gmail.com>
MIME-Version: 1.0
References: <b7f7accd0710160552x6d6e8a49h9646911eb2a94bf8@mail.gmail.com>
Subject: Re: [Bluez-users] Regarding GetInfo
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2127508697=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============2127508697==
Content-Type: multipart/alternative;
	boundary="----=_Part_16397_31673123.1192592907516"

------=_Part_16397_31673123.1192592907516
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Everyone,
I want to get device class. But DBus API's are available for getting device
Major class, Minor class and service class. But no API to get device class.
To get Device class I have two options,
1. Get device class from GetInfo.
2. Get Major class, Minor class and service class and from that construct
device class.
So I choose first way, But I am not able to get device class.

To get information about adapter, I have written code like this.

msg = dbus_message_new_method_call("org.bluez", "/org/bluez/hci0",
INTERFACE,"GetInfo");
        reply = dbus_connection_send_with_reply_and_block (conn,msg,
-1,&error);
        dbus_message_iter_init (reply, &iter);
        printf("\nSignature::%s",dbus_message_get_signature(reply));
        cout<<"\nIter signature::"<<dbus_message_iter_get_signature(&iter);
        dbus_message_iter_recurse (&iter, &dict_iter);
        cout<<"\ndict_Iter
signature::"<<dbus_message_iter_get_signature(&dict_iter);
        dbus_message_iter_recurse (&dict_iter, &data_iter);
        cout<<"\ndata_Iter
signature::"<<dbus_message_iter_get_signature(&data_iter);
        while (dbus_message_iter_has_next(&data_iter))
        {
            cout<<"\ndata
type::"<<(dbus_message_iter_get_arg_type(&data_iter));
            dbus_message_iter_next(&data_iter);
        }

But its not working. When I print signatures, it is printing like this
Signature::a{sv}
Iter signature::a{sv}
dict_Iter signature::{sv}
data_Iter signature::s
data type::115

And I found that,
 a{sv} is a dictionary with 's'tring keys and 'v'ariants as values

So does that mean GetInfo is returning only one key value pair?
Or I am missing something?

Regards
Yogesh

On 10/16/07, Yogesh Jagtap <jagtapyb@gmail.com> wrote:
>
> Hello everyone,
>
> How can I retrive values returned by GetInfo api?
>
> Regards
> Yogesh
>

------=_Part_16397_31673123.1192592907516
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Everyone,<br>I want to get device class. But DBus API&#39;s are available for getting device Major class, Minor class and service class. But no API to get device class. To get Device class I have two options,<br>1. Get device class from GetInfo.
<br>2. Get Major class, Minor class and service class and from that construct device class.<br>So I choose first way, But I am not able to get device class.<br><br>To get information about adapter, I have written code like this.
<br><br>msg = dbus_message_new_method_call(&quot;org.bluez&quot;, &quot;/org/bluez/hci0&quot;, INTERFACE,&quot;GetInfo&quot;);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reply = dbus_connection_send_with_reply_and_block (conn,msg, -1,&amp;error);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dbus_message_iter_init (reply, &amp;iter);
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;\nSignature::%s&quot;,dbus_message_get_signature(reply));<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; cout&lt;&lt;&quot;\nIter signature::&quot;&lt;&lt;dbus_message_iter_get_signature(&amp;iter);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dbus_message_iter_recurse (&amp;iter, &amp;dict_iter);
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; cout&lt;&lt;&quot;\ndict_Iter signature::&quot;&lt;&lt;dbus_message_iter_get_signature(&amp;dict_iter);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dbus_message_iter_recurse (&amp;dict_iter, &amp;data_iter);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; cout&lt;&lt;&quot;\ndata_Iter signature::&quot;&lt;&lt;dbus_message_iter_get_signature(&amp;data_iter);
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; while (dbus_message_iter_has_next(&amp;data_iter))<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; cout&lt;&lt;&quot;\ndata type::&quot;&lt;&lt;(dbus_message_iter_get_arg_type(&amp;data_iter));<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dbus_message_iter_next(&amp;data_iter);
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br><br>But its not working. When I print signatures, it is printing like this<br>Signature::a{sv}<br>Iter signature::a{sv}<br>dict_Iter signature::{sv}<br>data_Iter signature::s<br>data type::115<br><br>And I found that,
<br>&nbsp;a{sv} is a dictionary with &#39;s&#39;tring keys and &#39;v&#39;ariants as values<br><br>So does that mean GetInfo is returning only one key value pair?<br>Or I am missing something?<br><br>Regards<br>Yogesh<br><br><div>
<span class="gmail_quote">On 10/16/07, <b class="gmail_sendername">Yogesh Jagtap</b> &lt;<a href="mailto:jagtapyb@gmail.com">jagtapyb@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hello everyone,<br><br>How can I retrive values returned by GetInfo api? <br><br>Regards<br><span class="sg">Yogesh<br>
</span></blockquote></div><br>

------=_Part_16397_31673123.1192592907516--


--===============2127508697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============2127508697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2127508697==--
