Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Sudha S <sudhas.raghavan@gmail.com>
Date: Wed, 12 Apr 2017 14:45:58 +0530
Message-ID: <CAK8T_aW_zbOZxKR762D77a7sSZMAJno-12i9gj-31WFmnZ4o5A@mail.gmail.com>
Subject: Errors with SelectConfiguration callback implementation with bluez
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi ,

  I am a Bluez newbie and wanted your help with an issue that I am facing .
My linux system is running bluez 5.42 . The bluetooth application is
implementing media-api.txt api's to stream audio to a bluetooth
speaker .
The Registration to end point is succesfful with SBC as the codec.
Once this is successful, the application registers for the
SelectConfiguration and SetConfiguration callback . These are defined
in a xml .
In my application, I am receiving the "SelectConfiguation" callback .
With this , a reply is sent to bluez with the selected parameters .

However I am getting the following errors :
-------------------------------------------------------------------------------------------------------
../bluez-5.42/profiles/audio/media.c:media_endpoint_async_call()
Calling SelectConfiguration: name = :1.1 path =
/MediaEndpoint/A2DPSource
 Endpoint replied with an error: org.freedesktop.DBus.Error.NoReply
../bluez-5.42/profiles/audio/a2dp.c:select_cb() Endpoint replied an
invalid configuration

Request your inputs on this .

The code snippet when sending a reply to the "SelectConfiguration"

static void handle_method_call(GDBusConnection *conn,
                       const gchar *sender,
                       const gchar *object_path,
                       const gchar *interface_name,
                       const gchar *method_name,
                       GVariant *parameters,
                       GDBusMethodInvocation *invocation,
                       gpointer user_data)

{

  if (!g_strcmp0(method_name, "SelectConfiguration")) {
    printf("SelectConfiguration received !!!!!!!!!");

   GVariantBuilder *c;
    GVariant* arr;

    c = g_variant_builder_new(G_VARIANT_TYPE ("ay"));
    g_variant_builder_add(c , "y", 0x21);
    g_variant_builder_add(c , "y", 0x15);
    g_variant_builder_add(c , "y", 2);
    g_variant_builder_add(c , "y", 32);
    arr = g_variant_builder_end (c);
   GVariant* tupleParam = g_variant_new_tuple(&arr, 1);
   GDBusMessage *reply;
   reply = g_dbus_message_new_method_reply
(g_dbus_method_invocation_get_message (invocation));
   g_dbus_message_set_body(reply, tupleParam);
  GError* error = NULL;
  bool result = g_dbus_connection_send_message(mGdbusConnection,
                                               reply,
                                               G_DBUS_SEND_MESSAGE_FLAGS_NONE,
                                               NULL,
                                               &error);

}

Thanks ,
Sudha.S
